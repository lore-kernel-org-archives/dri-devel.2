Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63079CD6E64
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1FB10E7B4;
	Mon,  1 Jun 2026 13:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="NkqfjVGT";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF3E10E7B4
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=oXODjuqrY4OBNW73p3++vJQePAvD2CddI9jj9bMuC9U=; b=N
 kqfjVGTMhJtZs6BaN/bpi1eK9gxiOQbO9W7+kp7SPmHco1+Ac3WcJG2fSRl2S2DL
 hPysTQkGX6t4UnzvLvt6QeAuNoQCl7QHMQASsPWjrK/CHtETaw+fCsE53oOEPzEn
 o4JNoYhinzSy3a+7fR+mFhVU06d5avW7cdgRmWVad4=
Received: from andyshrk$163.com ( [61.154.14.86] ) by
 ajax-webmail-wmsvr-40-120 (Coremail) ; Mon, 1 Jun 2026 21:44:15 +0800 (CST)
X-Originating-IP: [61.154.14.86]
Date: Mon, 1 Jun 2026 21:44:15 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: "Sandy Huang" <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andy Yan" <andy.yan@rock-chips.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH 0/2] YUV support for VOP2 background color
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260524-vop2-bg-yuv-v1-0-dcb6a52923f5@collabora.com>
References: <20260524-vop2-bg-yuv-v1-0-dcb6a52923f5@collabora.com>
X-CM-CTRLMSGS: FN07+3BsdXM9MTc4MDMyMTQ1NTA1MF9kNmRjY2YzNjU0MmEwNTIyYjc0YWExM
 mI1MmZiMDMyMg==
X-NTES-SC: AL_Qu2TAv+Zvkwu4yObYukfmUgWjuw/WsG1v/Ul1YBSP556jDLp4yQsdlhFB13k6v+RMTGlqAieVTxg0OFXWa1WfaYt+PjPcFvWK/NZy9+E76AqHw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <8061cc0.a9f1.19e836d8cf0.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: eCgvCgD3_0ivjB1q9MivAA--.26891W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbCxg8wjmodjK9X4AAA3U
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

CkhlbGxvIENyaXN0aWFuLAoKQXQgMjAyNi0wNS0yNSAwMDoyNzoyNywgIkNyaXN0aWFuIENpb2Nh
bHRlYSIgPGNyaXN0aWFuLmNpb2NhbHRlYUBjb2xsYWJvcmEuY29tPiB3cm90ZToKPlNpbmNlIGNv
bW1pdCBiZWM3Y2JmYTdkNGYgKCJkcm0vcm9ja2NoaXA6IHZvcDI6IFN1cHBvcnQgc2V0dGluZyBj
dXN0b20KPmJhY2tncm91bmQgY29sb3IiKSB0aGUgVk9QMiBkaXNwbGF5IGNvbnRyb2xsZXIgYWxs
b3dzIGNvbmZpZ3VyaW5nIHRoZQo+YmFja2dyb3VuZCBjb2xvciBvZiBlYWNoIHZpZGVvIG91dHB1
dCBwb3J0Lgo+Cj5Ib3dldmVyLCB0aGlzIGlzIGN1cnJlbnRseSBsaW1pdGVkIHRvIFJHQiBmb3Jt
YXRzLiAgV2hlbiBvcGVyYXRpbmcgaW4KPllVViBvdmVybGF5IG1vZGUsIHRoZSBjb2xvciBtdXN0
IGJlIHByb2dyYW1tZWQgdXNpbmcgWVVWIGZvcm1hdC4KPgo+QWRkIHRoZSBuZWNlc3NhcnkgUkdC
LXRvLVlDYkNyIGNvbnZlcnNpb24gbG9naWMsIGNvdmVyaW5nIGFsbCBjb2xvcgo+c3BhY2VzIHN1
cHBvcnRlZCBieSB0aGUgZGlzcGxheSBjb250cm9sbGVyOiBCVDYwMUwsIEJUNjAxRiwgQlQ3MDlM
IGFuZAo+QlQyMDIwTC4KPgoKCkRvIHlvdSBjdXJyZW50bHkgaGF2ZSBhIGJyYW5jaCB0aGF0IG1h
a2VzIGR3LWhkbWktcXAgb3V0cHV0IGluIFlVViBtb2RlID8KCj5TaWduZWQtb2ZmLWJ5OiBDcmlz
dGlhbiBDaW9jYWx0ZWEgPGNyaXN0aWFuLmNpb2NhbHRlYUBjb2xsYWJvcmEuY29tPgo+LS0tCj5D
cmlzdGlhbiBDaW9jYWx0ZWEgKDIpOgo+ICAgICAgZHJtL3JvY2tjaGlwOiB2b3AyOiBSZW5hbWUg
Q1NDX0JUMjAyMCB0byBDU0NfQlQyMDIwTAo+ICAgICAgZHJtL3JvY2tjaGlwOiB2b3AyOiBBZGQg
WVVWIHN1cHBvcnQgdG8gYmFja2dyb3VuZCBjb2xvcgo+Cj4gZHJpdmVycy9ncHUvZHJtL3JvY2tj
aGlwL3JvY2tjaGlwX2RybV92b3AyLmMgfCAxNTQgKysrKysrKysrKysrKysrKysrKysrKysrLS0t
Cj4gZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV92b3AyLmggfCAgIDIgKy0K
PiAyIGZpbGVzIGNoYW5nZWQsIDEzOSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPi0t
LQo+YmFzZS1jb21taXQ6IDIxM2M5MmFjOTcxN2U0OTUxZjA1MmE0OTlmOTFjODkzMDI4ODk4MTMK
PmNoYW5nZS1pZDogMjAyNjA1MjQtdm9wMi1iZy15dXYtMWIwZTZhMDljNTc5Cj4K
