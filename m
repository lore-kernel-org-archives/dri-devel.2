Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660C7CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D244E10E623;
	Tue, 26 May 2026 11:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Yp7lfk3K";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9E910E623
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=+0sPyzuSHlLoJAd87i/e3m0e8N619YAooFpJZS/llgA=; b=Y
 p7lfk3KuXdF/NX3kF9S4mqcEdfoyTxGLBbQWti6D24hDkf33OEnbxTpkl21QMLoq
 T/9AzoASk8kEMxCh6SCBZzkpR+dVjZjP3cNw7NLf9a7UuHVZCMNdwb7VkrdX8FOg
 4cBTBphBoDKakAO0D117sF+zMFqbEZS8TuVO12qqNk=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-141 (Coremail) ; Tue, 26 May 2026 19:16:23 +0800
 (CST)
X-Originating-IP: [113.200.174.80]
Date: Tue, 26 May 2026 19:16:23 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>
Cc: "Greg KH" <gregkh@linuxfoundation.org>, louis.chauvet@bootlin.com,
 hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable
 and timer callback
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
References: <20260515131826.388154-1-w15303746062@163.com>
 <2026051557-thermal-petite-7da0@gregkh>
 <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
 <2026051633-skyward-parrot-cdd3@gregkh>
 <397754a7.224c.19e38e42006.Coremail.w15303746062@163.com>
 <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
X-NTES-SC: AL_Qu2cC/uSu0kj5SaYbOkfmU0Qguw9Xcq5uPkj34FWN5t8jCrr+ScQXEB9PUv50tuDMAuVihKOaARIx+pFfqh7RpoTzlm0XpsHjmuGni5I5i2vMQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <63508f34.98ff.19e640005c5.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: jSgvCgD3X1oHgRVqdLqsAA--.13543W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wdBJWoVgQfVegAA3W
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

CkhpIE1hYXJ0ZW4sCgo+QXMgZmFyIGFzIEkgY2FuIHRlbGwsIGlmIGl0J3MganVzdCBhIGJ1ZyBh
ZmZlY3RpbmcgdmttcywgYWxsIHlvdSBuZWVkIHRvIGRvCj5pcyBvbmx5IGEgZmV3IGNvbW1pdHM6
Cj4KPjc0YWZlYjgxMjg1MCAoImRybS92Ymxhbms6IEFkZCB2YmxhbmsgdGltZXIiKQo+ZDU0ZGJi
NTk2M2JkICgiZHJtL3ZibGFuazogQWRkIENSVEMgaGVscGVycyBmb3Igc2ltcGxlIHVzZSBjYXNl
cyIpCj4wMmUyNjgxZmZlMWEgKCJkcm0vdmttczogQ29udmVydCB0byBEUk0ncyB2YmxhbmsgdGlt
ZXIiKQo+NzlhZTg1MTBiNWI4ICgiZHJtL2F0b21pYzogSW5jcmVhc2UgdGltZW91dCBpbiBkcm1f
YXRvbWljX2hlbHBlcl93YWl0X2Zvcl92YmxhbmtzKCkiKQo+Mzk0NmQzYmE5OTM0ICgiZHJtL3Zi
bGFuazogRml4IGtlcm5lbCBkb2NzIGZvciB2YmxhbmsgdGltZXIiKQo+Cj5UaGVyZSdzIG5vIG5l
ZWQgdG8gY29udmVydCBhbGwgb3RoZXIgZHJpdmVycyBpZiBpdCdzIG9ubHkgdmttcyB0aGF0IHlv
dSdyZSBmaXhpbmcuCgpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciBwb2ludGluZyBvdXQgdGhpcyBw
cmVjaXNlIGRlcGVuZGVuY3kgY2hhaW4uIEl0IGNvbXBsZXRlbHkgc2F2ZWQgdGhlIGJhY2twb3J0
IGVmZm9ydC4gSSBoYXZlIGNoZXJyeS1waWNrZWQgdGhlc2UgNSBjb21taXRzIG9udG8gdGhlIDYu
MTgueSBicmFuY2gsIGFuZCB0aGV5IGFwcGx5IGNsZWFubHkgd2l0aG91dCBwdWxsaW5nIGluIHRo
ZSBtYXNzaXZlIERSTSBjb3JlIHJlZmFjdG9yaW5nLiAKClRoaXMgc2VyaWVzIGNvbXBsZXRlbHkg
cmVzb2x2ZXMgdGhlIFN5emthbGxlciBSQ1Ugc3RhbGwgKHNvZnQgbG9ja3VwKSBJIHdhcyBvYnNl
cnZpbmcgaW4gbXkgbG9jYWwgZnV6emluZyBlbnZpcm9ubWVudC4gSSBoYXZlIGp1c3Qgc3VibWl0
dGVkIHRoaXMgNS1wYXRjaCBzZXJpZXMgdG8gdGhlIGxpc3QuCgo+QnV0IHNpbmNlIHlvdSBmb3Vu
ZCB0aGlzIGJ1ZyBpbiBvbmUgZHJpdmVyLCBpdCBtaWdodCBiZSB3aXNlIHRvIGNoZWNrIGlmIG90
aGVycwo+aGF2ZSB0aGUgc2FtZSBidWcgYW5kIGFzayBmb3IgYmFja3BvcnRzIGZvciB0aG9zZSB0
b28uCgpGb2xsb3dpbmcgeW91ciBzdWdnZXN0aW9uLCBJIGNvbmR1Y3RlZCBhIHN0YXRpYyBsb2Nr
IGRlcGVuZGVuY3kgYXVkaXQgYWNyb3NzIHRoZSBkcml2ZXJzL2dwdS9kcm0vIHN1YnN5c3RlbSBp
biB0aGUgNi4xOC55IHRyZWUsIHNwZWNpZmljYWxseSBsb29raW5nIGZvciBzaW1pbGFyIGFidXNl
cyBvZiBocnRpbWVyX2NhbmNlbCBwYWlyZWQgd2l0aCBjdXN0b20gdmJsYW5rL3BvbGxpbmcgdGlt
ZXJzLgoKSSBhdWRpdGVkIHRoZSBoaWdobHkgc3VzcGljaW91cyBjYW5kaWRhdGVzLCBpbmNsdWRp
bmc6CgoxLiBpOTE1L2d2dCAodmlydHVhbCBkaXNwbGF5IGVtdWxhdGlvbjogdmJsYW5rX3RpbWVy
X2ZuIHZzIGludGVsX3ZncHVfY2xlYW5fZGlzcGxheSkKMi4geGUgKE9BIGJ1ZmZlciBwb2xsaW5n
OiB4ZV9vYV9wb2xsX2NoZWNrX3RpbWVyX2NiIHZzIHhlX29hX3N0cmVhbV9kaXNhYmxlKQozLiBt
c20gKGZlbmNlIGRlYWRsaW5lcyAmIGRldmZyZXE6IGRlYWRsaW5lX3RpbWVyIHZzIG1zbV91cGRh
dGVfZmVuY2UpCgpGb3J0dW5hdGVseSwgdGhlc2UgZHJpdmVycyBhcmUgc3RydWN0dXJhbGx5IHNh
ZmUgZnJvbSB0aGlzIHNwZWNpZmljIEFCQkEgZGVhZGxvY2sgcGF0dGVybi4gVGhleSBzdWNjZXNz
ZnVsbHkgYXZvaWQgaXQgZWl0aGVyIGJ5IGhlYXZpbHkgZGVjb3VwbGluZyB0aGUgdGltZXIgY2Fs
bGJhY2sgZnJvbSB0aGUgbG9jayBjb250ZXh0IHZpYSB3b3JrcXVldWVzIChtc21fZmVuY2UgYW5k
IGk5MTUvZ3Z0IG9ubHkgdXNlIHRoZSB0aW1lciB0byBzYWZlbHkgd2FrZV91cCBvciBxdWV1ZSB3
b3JrIHdpdGhvdXQgaG9sZGluZyBtdXRleGVzL3NwaW5sb2NrcyksIG9yIGJ5IHV0aWxpemluZyBm
aW5lLWdyYWluZWQgbG9ja2luZyB3aGVyZSB0aGUgY2FuY2VsIHBhdGggYW5kIHRoZSB0aW1lciBj
YWxsYmFjayBkbyBub3QgY29udGVzdCB0aGUgc2FtZSBsb2NrICh4ZSBzdHJlYW0gcG9sbGluZyku
CgpUaGVyZWZvcmUsIGl0IHNlZW1zIHZrbXMgd2FzIGEgdW5pcXVlIGxlZ2FjeSBvdXRsaWVyIGlu
IHRoaXMgcmVnYXJkLiBObyBmdXJ0aGVyIGJhY2twb3J0cyBhcmUgbmVlZGVkIGZvciBvdGhlciBE
Uk0gZHJpdmVycyBmb3IgdGhpcyBzcGVjaWZpYyB2dWxuZXJhYmlsaXR5LgoKVGhhbmtzIGFnYWlu
IGZvciB0aGUgcm9hZG1hcCBhbmQgdGhlIHRob3JvdWdoIHJldmlldy4KCkJlc3QgcmVnYXJkcywK
TWluZ3l1Cg==
