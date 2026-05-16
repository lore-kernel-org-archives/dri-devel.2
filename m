Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3875CD343F
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 02:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F2110E064;
	Sat, 16 May 2026 02:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="iQlF63E2";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD2310E064
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 02:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=ICKCX/tLCEDtejDHyXne+nOIIbge8mBJ5uanV2vlxAs=; b=i
 QlF63E2HOVlQdhbVRCWpFGeXuzsHWcjJ2+hQUSqSAsQsDWGkksq3Aps3ra/9vryD
 kFXzMGrlOuwTiO0FbSZ/8qNbyEsA0HSLsnbvOnnGfp6YA8cnnkrWOBJHZQToYEYH
 S7DVZwWgjNclOqemGbJY162x5B+FYFg5S5A8ELy5/U=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Sat, 16 May 2026 10:43:35 +0800
 (CST)
X-Originating-IP: [113.200.174.80]
Date: Sat, 16 May 2026 10:43:35 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: "Greg KH" <greg@kroah.com>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
 melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable
 and timer callback
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <2026051557-thermal-petite-7da0@gregkh>
References: <20260515131826.388154-1-w15303746062@163.com>
 <2026051557-thermal-petite-7da0@gregkh>
X-NTES-SC: AL_Qu2cCvSStkwq4yCbZ+kfmU0Qguw9Xcq5uPkj34FWN5t8jCDp6AkFeXhTAFnX++eoFB6+mRKZdCV3+PhceaBDXJgs/CVh6Xs9i5Zsll3yPlbkYQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: aigvCgD3X1LX2QdqChakAA--.278W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-xcI62oH2ddrzAAA3P
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

CkhpIEdyZWcsCgpUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZSBhbmQgcmV2aWV3LgoKCkF0
IDIwMjYtMDUtMTUgMjM6MDk6NDYsICJHcmVnIEtIIiA8Z3JlZ0Brcm9haC5jb20+IHdyb3RlOgo+
T24gRnJpLCBNYXkgMTUsIDIwMjYgYXQgMDk6MTg6MjZQTSArMDgwMCwgdzE1MzAzNzQ2MDYyQDE2
My5jb20gd3JvdGU6Cj4+IEZyb206IE1pbmd5dSBXYW5nIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFu
LmVkdS5jbj4KPj4gCj4+IFtOb3RlOiBUaGlzIHBhdGNoIGFkZHJlc3NlcyBhIGxlZ2FjeSBWS01T
IGltcGxlbWVudGF0aW9uIGRlYWRsb2NrIHNwZWNpZmljCj4+IHRvIG9sZGVyIHN0YWJsZSB0cmVl
cyAoZS5nLiwgNi4xOC55KS4gTWFpbmxpbmUgaGFzIHJlbW92ZWQgdGhpcyBjb2RlIGR1cmluZwo+
PiB0aGUgZ2VuZXJpYyBEUk1fQ1JUQ19WQkxBTktfVElNRVJfRlVOQ1MgcmVmYWN0b3JpbmcuXQo+
Cj5XaHkgbm90IGFwcGx5IHRob3NlIHVwc3RyZWFtIGNvbW1pdHMgaGVyZSBhcyB3ZWxsPyAgTm8g
bmVlZCB0byBkaXZlcmdlCj5mcm9tIExpbnVzJ3MgdHJlZSwgb3RoZXJ3aXNlIHdlIHdpbGwgZW5k
IHVwIGhhdmluZyBhIG1lc3MgdGhhdCBub3RoaW5nCj5jYW4gZXZlciBiZSBiYWNrcG9ydGVkIHRv
Lgo+Cj5Ib3cgbWFueSBjb21taXRzIG5lZWQgdG8gYmUgYmFja3BvcnRlZD8gIEhhdmUgeW91IHRy
aWVkPwoKSSBoYXZlIGxvb2tlZCBpbnRvIHRoZSB1cHN0cmVhbSBjb21taXRzLiBUaGUgY29tbWl0
IHRoYXQgcmVtb3ZlZCB0aGlzIAp2dWxuZXJhYmxlIGxlZ2FjeSBjb2RlIGluIG1haW5saW5lIGlz
OgowMmUyNjgxZmZlMWEgKCJkcm0vdmttczogQ29udmVydCB0byBEUk0ncyB2YmxhbmsgdGltZXIi
KQoKSSB0cmllZCB0byBhcHBseSBpdCB0byA2LjE4LnksIGJ1dCBpdCBkb2VzIG5vdCBhcHBseSBj
bGVhbmx5LiBUaGUgcmVhc29uIAppcyB0aGF0IHRoaXMgdXBzdHJlYW0gY29tbWl0IGlzIG5vdCBh
IHNpbXBsZSBidWcgZml4LCBidXQgYSBtYXNzaXZlIApyZWZhY3RvcmluZy4gSXQgY29tcGxldGVs
eSByaXBzIG91dCB0aGUgY3VzdG9tIFZLTVMgaHJ0aW1lciBhbmQgcG9ydHMgCnRoZSBkcml2ZXIg
dG8gYSBuZXdseSBpbnRyb2R1Y2VkIERSTSBjb3JlIGluZnJhc3RydWN0dXJlIAooRFJNX0NSVENf
VkJMQU5LX1RJTUVSX0ZVTkNTIGFuZCBkcm1fdmJsYW5rX2hlbHBlci5oKS4KClRvIGJhY2twb3J0
IGNvbW1pdCAwMmUyNjgxZmZlMWEsIHdlIHdvdWxkIGZpcnN0IG5lZWQgdG8gYmFja3BvcnQgdGhl
IAplbnRpcmUgRFJNIGdlbmVyaWMgdmJsYW5rIHRpbWVyIGluZnJhc3RydWN0dXJlIHRvIDYuMTgu
eS4gVGhpcyBzZWVtcyAKdG9vIGludHJ1c2l2ZSBhbmQgdmlvbGF0ZXMgdGhlIG1pbmltYWwtcmlz
ayBwb2xpY3kgZm9yIHN0YWJsZSB0cmVlcy4KClRoZXJlZm9yZSwgc2luY2UgdGhlIGxlZ2FjeSBj
dXN0b20gaHJ0aW1lciBzdGlsbCBleGlzdHMgaW4gNi4xOC55IGFuZCAKaXMgYWN0aXZlbHkgY2F1
c2luZyBBQkJBIGRlYWRsb2NrcyAoUkNVIHN0YWxscyksIHRoaXMgbWluaW1hbGlzdGljIAphbmQg
bG9jYWxpemVkIHBhdGNoICh1c2luZyBocnRpbWVyX3RyeV90b19jYW5jZWwpIGlzIHByb3Bvc2Vk
IGFzIHRoZSAKc2FmZXN0IHdheSB0byBmaXggdGhlIGlzc3VlIHNwZWNpZmljYWxseSBmb3Igb2xk
ZXIgc3RhYmxlIGJyYW5jaGVzIAp3aXRob3V0IHB1bGxpbmcgaW4gbWFqb3IgRFJNIGNvcmUgcmVm
YWN0b3JpbmcuCgpXb3VsZCB0aGlzIGxvY2FsaXplZCBmaXggYmUgYWNjZXB0YWJsZSBmb3IgdGhl
IHN0YWJsZSB0cmVlPwoKVGhhbmtzLApNaW5neXUKCg==
