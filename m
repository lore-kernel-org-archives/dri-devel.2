Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0F606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V4IqbMPt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB7410E71B;
	Fri, 30 Oct 2026 18:31:58 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC1F10E71B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 18:31:51 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 88D8D40E02B7; 
 Fri, 30 Oct 2026 18:31:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fAISku3nizOb; Fri, 30 Oct 2026 18:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1793385106; bh=Pd4x6KX1MFlbuq4ED0KDljLa80KATn4gc4wWHX5+2d4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V4IqbMPt5+CJfLUEljqZ3/X9PwSKu+UW+l4hb9rDS7XlfiGavm1XLwtApelIy3wLu
 0Lj0ZWrFqY+SleXYGaqkqSMrCYaK13hdQHEw5jao0Pqp8JC66p9aNC6yLVimFlO90S
 uoS/Egnu2Reooyp6zek21i+wEQYPQCCsKYFSh5a3YkQ8Gg82fzdaofMb0h0xHbAJxp
 oQ80pYzMBAD9bS6+wBZCV8XEP+9A9ABEGEiXmPp8EWEFuuarSICdVl2+cEoMF31nfE
 FaKB6JaSE772qou3SZBYnZJQG9oB8/xpdINd8Frmt0z3IsX8htM2c/+D+U5r20CJzs
 DhHEYBXab90Nvz+cSB9QA2yThsknJCJWlW4xPzhjy7rOISVC7RyEGkcrXeP45Uy+P9
 4DLTbJ3wO5TUBEzBNPBhYRtSpp/oFiiRcD9tFDqA5BsWXIZ9PAcyoNNERbKIxz90F0
 2TgqhXBCAfUkJHrx7CHIo90G2dhDYrqlPXRYUAYLQnOGQRdPI/El09nUIaND62WyLH
 4qH7/uJZuF+Hn1CFdbNtz5SJRD2AZD20DzvNedZg0CRrOJEZK7F7jfFz0NJ1LI4mLt
 PoR+3ml7GXsN7THAuZc6z7ldVQNm21gAyeKOqqLlbmNkfCs4XlKqjd/QvUq4Ga51xQ
 BfmOBwsg2Gq1Z4NnMNYfrI7s=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2DD140E029C;
 Fri, 30 Oct 2026 18:31:37 +0000 (UTC)
Date: Fri, 30 Oct 2026 11:31:35 -0700
From: Borislav Petkov <bp@alien8.de>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: tzimmermann@suse.de, x86@kernel.org, mario.limonciello@amd.com,
 aaron.ma@canonical.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] x86/video: Preserve the default VGA fallback for legacy
 modes
Message-ID: <20261030183135.GCauTih7l-cCDO96dz@fat_crate.local>
References: <20261029162311.3389523-1-hengyul@cs.unc.edu>
 <4379fd92-ac4f-45c2-9f4a-eaabe4b7f981@suse.de>
 <20261030092422.300856-1-hengyul@cs.unc.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030092422.300856-1-hengyul@cs.unc.edu>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 05:24:21AM -0400, Hengyu Liang wrote:
> > Further below in that code is a call to pci_find_resource(). [1]  Why
> > does it match with vkms?  Vkms is not even on a PCI device.
> 
> It doesn't match vkms. As you say, vkms isn't a PCI device, so
> video_is_primary_device() returns false for it at the dev_is_pci() check.
> 
> The problem is on the bochs side. In text mode, screen_info_resources()
> returns the legacy VGA ranges, pci_find_resource() doesn't find them in
> the BARs, and the function returns false there as well. So no device is
> primary, and fbcon stays on the first registered framebuffer. In this
> setup that is vkms (fb0), so the console is never remapped to bochs (fb1).
> 
> vkms only makes the console part visible. Without vkms, tty1 has the same
> size with and without the patch, but boot_display is still missing without
> it.

Please update your commit message with this clarification.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
