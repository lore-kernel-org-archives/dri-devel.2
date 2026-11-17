Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78013606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AAl5RpHA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E0C10EF16;
	Tue, 17 Nov 2026 08:08:38 +0000 (UTC)
X-Greylist: delayed 386 seconds by postgrey-1.36 at gabe;
 Tue, 17 Nov 2026 06:46:57 UTC
Received: from mail-proxy25256.mail.163.com (mail-proxy25256.mail.163.com
 [103.129.252.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9153110E4AD;
 Tue, 17 Nov 2026 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
 MIME-Version; bh=6B+7GGPKPoceIm1D3QKyG/IV+mDK3ymAMTmo9dWxDOQ=;
 b=AAl5RpHAnvmUk/YsouV9rC2pAVzJUZJqFyveKhbm8wiyzoUZmgnUVkgilj5jl+
 JFYaJLrpoy5sCwcnt8YmLLXSbynhCsnGYeVbnnSh5+6JJNFtPh1n4dIabb+Rg0MQ
 nXx3ad7zpBpvnqbw7fvT2uuAEU4bYBxFxMJv/i9bh2KlQ=
From: Kean Ren <rh_king@163.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ryan Brue <ryanbrue.dev@gmail.com>,
 Derek J. Clark <derekjohn.clark@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH v3] PCI: Disable spurious s2idle wake from the NVMe root
 port on ThinkPad P1 Gen 9
In-Reply-To: <20261116202943.GA204660@bhelgaas>
References: <20261116202943.GA204660@bhelgaas>
Date: Tue, 17 Nov 2026 14:37:24 +0800
Message-ID: <179489744422.381071.5186601861347774408@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3vxwv9vtqkkWkIA--.34054S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw18uF4rGF4kJFW7Gr45Jrb_yoW8WrWfpr
 WvgFWYg3WkCFy0v39rXw4UJFZ3Zr1Sk3yfGF97t3s2y3Z8JrWfGrW3trn8ua48Ar1kWay2
 qw4Iya47Z3yUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfMa5UUUUU=
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC-BJjEmr79jKObAAA3o
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:19 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bjorn,
Thanks — and thanks for Cc'ing the Legion folks.
I don't think it is the same bug, although the pattern is similar.
Both cases are firmware firing a GPE on the parent PCIe port of a device
that is entering a low-power state, and both workarounds target the parent
port's wake handling.  The details differ:
 - Legion: the trigger is the NVIDIA dGPU entering D3cold during runtime
   suspend; the port (and then the GPU) is immediately woken again, in a
   loop.  The v4 patch removes the ACPI PM notifier from the parent port's
   ACPI device, which turns the GPE handling into a no-op.
 - ThinkPad P1 Gen 9 (21UF): the trigger is the primary NVMe SSD entering
   D3 during system suspend (s2idle).  Firmware leaves RP05's _PRW
   enabled; the spurious PME sets GPE 0x6F, and the SCI arrives during the
   noirq suspend phase and aborts s2idle after ~150 us.  The quirk disables
   wakeup on RP05 at late_initcall, so the port is not armed as a wake
   source at suspend time.  On this machine, masking GPE 0x6F or disabling
   RP05 via /proc/acpi/wakeup keeps s2idle asleep; without the quirk every
   suspend wakes after ~2.5 s.
So the two quirks are DMI/device specific and target different sleep paths
(runtime PM vs system s2idle).  I think they should stay separate; I can add
a Link: to the Legion series in the changelog if you prefer a
cross-reference.
For the Legion folks: does acpi_remove_pm_notifier() also keep the port from
being armed as a wake source for system suspend, or does it only make the
runtime-PM GPE handling a no-op?  In my case I don't think a notifier-only
change would have prevented the s2idle abort.
Thanks,
Kean

