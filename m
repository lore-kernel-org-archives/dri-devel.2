Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B895CCD4F3D
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 02:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9C310E00B;
	Mon, 18 May 2026 02:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="GZchvjGj";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDEE10E00B
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=I1Op4CwLvDbWIxcfGkebHPCoScSMbOGQXbJlutSUWLw=; b=G
 ZchvjGjEUjNMgjm0EKvFdbKrojaawiOgvfPLt20HWnQRV4yBEg7UirjEu1YIcc31
 rixtwA00BILuL0yCHiB+qRHja3+aX8hRPmtcQEm/LOsncrs7kDyUVJ/xZZPgyPam
 U1rA5+D+q6yDRGYHSZAQFa7uItNR3A1YkHbxsaf5xQ=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-124 (Coremail) ; Mon, 18 May 2026 10:22:15 +0800
 (CST)
X-Originating-IP: [113.200.174.80]
Date: Mon, 18 May 2026 10:22:15 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
 melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re: Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank
 disable and timer callback
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <2026051633-skyward-parrot-cdd3@gregkh>
References: <20260515131826.388154-1-w15303746062@163.com>
 <2026051557-thermal-petite-7da0@gregkh>
 <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
 <2026051633-skyward-parrot-cdd3@gregkh>
X-NTES-SC: AL_Qu2cC/ycv0Eo4yCbZukfmU0Qguw9Xcq5uPkj34FWN5t8jAvp5C0KcnBkF0HIze+BMCOAuyS4cSFE6/lLUql7RY0zMjg6SCYDH/nzU6ccMpk01w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <397754a7.224c.19e38e42006.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: fCgvCgDXlyfXdwpqSjKhAA--.648W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4xcwFGoKd9eYxgAA3O
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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

CgpBdCAyMDI2LTA1LTE2IDE3OjUxOjU5LCAiR3JlZyBLSCIgPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPiB3cm90ZToKPlRoZXJlIGlzIG5vICJtaW5pbWFsLXJpc2sgcG9saWN5IGZvciBzdGFi
bGUgdHJlZXMiLiAgQW5kIGlmIHRoZXJlIHdhcywKPnRoZSBsZWFzdCBhbW1vdW50IG9mIHJpc2sg
d291bGQgYmUgdG8gdGFrZSB0aGUgcmV2aWV3ZWQgYW5kIHRlc3RlZAo+cGF0Y2hlcyB0aGF0IGFy
ZSBhbHJlYWR5IGluIExpbnVzJ3MgdHJlZSwgYW5kIE5PVCB0YWtlIGFueXRoaW5nIHRoYXQgaXMK
Pm5vdCBhbHJlYWR5IHRoZXJlLCBhcyA5MCUgb2YgdGhlIHRpbWUgdGhhdCB3ZSBkbyB0aGF0LCBp
dCBjb21lcyBiYWNrIHRvCj5iaXRlIHVzIGhhcmQuCj4KPlNvIHBsZWFzZSwganVzdCBiYWNrcG9y
dCBhbGwgdGhlIG5lZWRlZCBjaGFuZ2VzIGhlcmUuICBPdGhlcndpc2UgaG93IGFyZQo+d2UgZ29p
bmcgdG8gZGVhbCB3aXRoIHRoZSBtZXJnZSBjb25mbGljdHMgZm9yIHRoZSBuZXh0IDQgeWVhcnMg
aW4gdGhpcwo+ZmlsZT8KPgo+T3IsIGdldCB0aGUgbWFpbnRhaW5lcnMgb2YgdGhpcyBmaWxlIHRv
IGFncmVlIGFuZCByZXZpZXcgdGhpcyBvbmUtb2ZmCj5jaGFuZ2UgdGhhdCBpdCBpcyBhY2NlcHRh
YmxlLiAgQXMgdGhleSBhcmUgZ29pbmcgdG8gYmUgdGhlIG9uZXMgZ2V0dGluZwo+dGhlIGJ1ZyBy
ZXBvcnRzIGFuZCBub3QgaGF2aW5nIHRoZWlyIHBhdGNoZXMgYXBwbGllZCBvdmVyIHRoZSB5ZWFy
cywgbm90Cj5hbnlvbmUgZWxzZSA6KQoKSGkgR3JlZywKCkdvdCBpdC4gQWZ0ZXIgbG9va2luZyBk
ZWVwZXIgaW50byB0aGUgZGVwZW5kZW5jeSBjaGFpbiwgYmFja3BvcnRpbmcgdGhlIG1haW5saW5l
IGNvbW1pdCAoMDJlMjY4MWZmZTFhKSB3b3VsZCBpbmRlZWQgcmVxdWlyZSBwdWxsaW5nIGluIHRo
ZSBlbnRpcmUgbmV3IERSTSBnZW5lcmljIHZibGFuayB0aW1lciBpbmZyYXN0cnVjdHVyZSB0byA2
LjE4LnkuIAoKVGhhdCBzY29wZSBpcyBqdXN0IHRvbyBsYXJnZSBhbmQgY29tcGxleCBmb3IgdGhp
cyBzcGVjaWZpYyBpc3N1ZS4gU2luY2UgYSBvbmUtb2ZmIHBhdGNoIGlzIG5vdCB0aGUgcmlnaHQg
YXBwcm9hY2ggZWl0aGVyLCBJIHdpbGwganVzdCBkcm9wIHRoaXMgcGF0Y2ggYW5kIGFiYW5kb24g
dGhlIGJhY2twb3J0IGVmZm9ydCBmb3IgNi4xOC55LgoKVGhhbmtzIGZvciB5b3VyIHRpbWUgYW5k
IHRoZSBxdWljayByZXZpZXcuCgpUaGFua3MsCk1pbmd5dQoK
