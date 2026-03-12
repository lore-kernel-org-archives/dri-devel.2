Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684F8106ACE2
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58DB10EA98;
	Thu, 12 Mar 2026 19:33:47 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B9310EA98;
 Thu, 12 Mar 2026 19:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 4DE582C14A8;
 Thu, 12 Mar 2026 20:33:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id yCwNT8mwVvHB; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 8A34D2C14AA;
 Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3HN7guaAFMsE; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by lithops.sigma-star.at (Postfix) with ESMTP id ABF4A2C14A6;
 Thu, 12 Mar 2026 20:33:42 +0100 (CET)
Date: Thu, 12 Mar 2026 20:33:42 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>, 
 apparmor <apparmor@lists.ubuntu.com>, bpf <bpf@vger.kernel.org>, 
 ceph-devel <ceph-devel@vger.kernel.org>, cocci <cocci@inria.fr>, 
 dm-devel@lists.linux.dev, 
 DRI mailing list <dri-devel@lists.freedesktop.org>, 
 gfs2 <gfs2@lists.linux.dev>, intel-gfx <intel-gfx@lists.freedesktop.org>, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, 
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
 linux-block <linux-block@vger.kernel.org>, 
 linux-bluetooth@vger.kernel.org, 
 linux-btrfs <linux-btrfs@vger.kernel.org>, 
 linux-cifs <linux-cifs@vger.kernel.org>, linux-clk@vger.kernel.org, 
 linux-erofs <linux-erofs@lists.ozlabs.org>, 
 linux-ext4 <linux-ext4@vger.kernel.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-gpio@vger.kernel.org, linux-hyperv <linux-hyperv@vger.kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, 
 linux-leds@vger.kernel.org, linux-media <linux-media@vger.kernel.org>, 
 linux-mips <linux-mips@vger.kernel.org>, 
 linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org, 
 linux-mtd <linux-mtd@lists.infradead.org>, 
 linux-nfs <linux-nfs@vger.kernel.org>, 
 linux-omap <linux-omap@vger.kernel.org>, 
 linux-phy@lists.infradead.org, linux-pm <linux-pm@vger.kernel.org>, 
 linux-rockchip <linux-rockchip@lists.infradead.org>, 
 linux-s390 <linux-s390@vger.kernel.org>, 
 linux-scsi <linux-scsi@vger.kernel.org>, linux-sctp@vger.kernel.org, 
 LSM <linux-security-module@vger.kernel.org>, 
 linux-sh <linux-sh@vger.kernel.org>, 
 linux-sound <linux-sound@vger.kernel.org>, 
 linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>, 
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
 linux-usb@vger.kernel.org, 
 linux-wireless <linux-wireless@vger.kernel.org>, 
 netdev <netdev@vger.kernel.org>, ntfs3 <ntfs3@lists.linux.dev>, 
 samba-technical <samba-technical@lists.samba.org>, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs <v9fs@lists.linux.dev>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1584421372.26258.1773344022512.JavaMail.zimbra@nod.at>
In-Reply-To: <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
Subject: Re: [PATCH 48/61] mtd: Prefer IS_ERR_OR_NULL over manual NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF148
 (Linux)/8.8.12_GA_3809)
Thread-Topic: Prefer IS_ERR_OR_NULL over manual NULL check
Thread-Index: 0l8CyewQmrWlgaG6N3QgQFfukutRbA==
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Philipp Hahn" <phahn-oss@avm.de>
> -=09if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
> +=09if (!IS_ERR_OR_NULL(gpiomtd->nwp))

No, please don't.

This makes reading the code not easier.

Thanks,
//richard
