Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5159FF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E2F10E22B;
	Mon, 27 Apr 2026 09:09:22 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDF910E294
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 09:09:20 +0000 (UTC)
X-UUID: c2cfe116421811f1aa26b74ffac11d73-20260427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:6e6e2a2e-4510-4cd1-b266-d46dfa3756de, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:09687ec979f74c39610f8597101db751,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:80|83|102|898,TC:nil,Content:4|15|50,EDM
 :-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
 ,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c2cfe116421811f1aa26b74ffac11d73-20260427
X-User: aichao@kylinos.cn
Received: from thinksys.. [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <aichao@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1524292456; Mon, 27 Apr 2026 17:09:14 +0800
From: Ai Chao <aichao@kylinos.cn>
To: deller@gmx.de, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux@armlinux.org.uk, dilinger@queued.net,
 adaplas@gmail.com, James.Bottomley@HansenPartnership.com,
 FlorianSchandinat@gmx.de, alchark@gmail.com, krzk@kernel.org,
 kees@kernel.org, rene@exactco.de, tzimmermann@suse.de,
 rongqianfeng@vivo.com, thorsten.blum@linux.dev,
 chelsyratnawat2001@gmail.com, soci@c64.rulez.org,
 gregkh@linuxfoundation.org, daniel@thingy.jp, linmq006@gmail.com,
 fourier.thomas@gmail.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-geode@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: Re: [PATCH 03/35] fbdev: sisfb: Use safer strscpy() instead of
 strcpy()
Date: Mon, 27 Apr 2026 17:09:10 +0800
Message-Id: <20260427090910.1940231-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello David and Helge
...
> > > -            strcpy(ivideo->myid, "SiS 730");
> > > +            strscpy(ivideo->myid, "SiS 730");  
> > 
> > The compiler knows at build time the length of myid, and the "SIS 730" string.
> > Using strscpy() has no benefit here either. Contrary, the code generated
> > because of using strscpy() is probably even larger.
> > Don't replace such code with strscpy().

> Both should get converted to a memcpy().

> If you increase the literal to be too long I'm pretty sure you'll
> get a compiler warning/error from strcpy().
> OTOH strscpy() is more likely to truncate the string (I'd need to
> check).

> So leaving it as strcpy() is fine - and possibly even better.
> The header files might get changed to error strcpy() unless the compiler
> knows the source string has a constant length and the destination is
> big enough - but that hasn't been done yet.

struct sis_video_info {
    char    myid[40];
}
I have rewritten the code: 
strcpy(ivideo->myid, "SiS 730-0123456789abcdefghijklmnopqrstuvwxyz0123456789");
Used gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04.3)
There was no compiler warning or error. 
The strcpy copies the entire string into myid(causing a buffer overflow),
whereas strscpy only copies 40 characters into myid according to its size.

Thanks,
Ai Chao
