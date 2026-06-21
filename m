Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDDBCD4F26
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 02:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F0A10E2DE;
	Sun, 21 Jun 2026 02:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="EQK9h/SQ";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED8B10E2DE
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 02:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=FeZ4c+JE0/8bQv3Zo1HRkUD46feEweJT7tGEM62N5Bs=; b=E
 QK9h/SQ2Gg6KaI6iQSD58wF4nTPnlWtc4jKeK0SW3p+02kMW6ZPRb7Fc+47LsrTk
 icJtdXLo+izvgvg0s5QF0fLhgpdbaN1XaqTNHZuzZDSHxzOPNY8Qj96bfWzENfLh
 bezAs9mBsypB5iq8xvLGM2HQXJiaQw9jkHb92HoxII=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Sun, 21 Jun 2026 10:53:51 +0800
 (CST)
X-Originating-IP: [113.200.174.80]
Date: Sun, 21 Jun 2026 10:53:51 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re:[PATCH v2] drm/gem: fix signed integer overflow in idr_alloc
 end parameter
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <201b9524.566.19ee7f7eeb3.Coremail.w15303746062@163.com>
References: <20260605142644.1205922-1-w15303746062@163.com>
 <201b9524.566.19ee7f7eeb3.Coremail.w15303746062@163.com>
X-NTES-SC: AL_Qu2TAPyav0wo5yKYYukfmU0Qguw9Xcq5uPkj34FWN5t8jADpwzI7RW1pP0r96smPBi2roia6Vihk6/hcX6hdeo4W+6V3ZecsTmOHt3Lx1jV9MQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5732bce4.6fc.19ee81946f1.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: gSgvCgCn_zE_UjdqOAYNAA--.398W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5B8M72o3Uj87wAAA3T
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

Cj5HZW50bGUgcGluZyBvbiB0aGlzIHYyIHBhdGNoLiAKPgo+QXMgYSBxdWljayBub3RlIHJlZ2Fy
ZGluZyB0aGUgYXV0b21hdGVkIHJldmlldyBmcm9tIFNhc2hpa28gQUk6IGl0IGNvcnJlY3RseSBm
bGFnZ2VkIHR3byBwcmUtZXhpc3RpbmcgaXNzdWVzIGluIHRoaXMgZnVuY3Rpb24gKGEgbWlzc2lu
ZyBpZHJfcHJlbG9hZCBhbmQgYSBjcml0aWNhbCBVQUYgcmFjZSBjb25kaXRpb24gZHVyaW5nIERS
TV9JT0NUTF9HRU1fQ0xPU0UpLiAKPgo+SSB3YW50IHRvIGNsYXJpZnkgdGhhdCB0aG9zZSBhcmUg
b3J0aG9nb25hbCB0byB0aGUgaW50ZWdlciBvdmVyZmxvdyBmaXhlZCBpbiB0aGlzIHYyIHBhdGNo
LiBJIGFtIGtlZXBpbmcgdGhpcyBwYXRjaCBwdXJlbHkgZm9jdXNlZCBvbiB0aGUgc2lnbmVkIGlu
dGVnZXIgb3ZlcmZsb3cgaXNzdWUgc28gaXQgY2FuIGJlIGV2YWx1YXRlZCBvbiBpdHMgb3duIG1l
cml0cy4gCj4KPkkgYW0gY3VycmVudGx5IGludmVzdGlnYXRpbmcgdGhlIFVBRiByYWNlIGNvbmRp
dGlvbiBzZXBhcmF0ZWx5IGFuZCB3aWxsIHN1Ym1pdCBhIG5ldyBwYXRjaCBzZXJpZXMgdG8gYWRk
cmVzcyB0aGUgcHJlLWV4aXN0aW5nIGJ1Z3MgZmxhZ2dlZCBieSB0aGUgYm90Lgo+Cj5QbGVhc2Ug
bGV0IG1lIGtub3cgaWYgYW55IGZ1cnRoZXIgcmV2aXNpb25zIGFyZSBuZWVkZWQgZm9yIHRoaXMg
djIgb3ZlcmZsb3cgZml4LgoKSGkgYWxsLAoKRm9sbG93aW5nIHVwIG9uIG15IHByZXZpb3VzIGVt
YWlsLCBJIGp1c3Qgbm90aWNlZCB0aGF0CmRybV9nZW1fY2hhbmdlX2hhbmRsZV9pb2N0bCBoYXMg
cmVjZW50bHkgYmVlbiBkaXNhYmxlZCBpbiBtYWlubGluZSBkdWUgdG8Kc2VjdXJpdHkgYW5kIHRl
c3RpbmcgY29uY2VybnMsIGFuZCBhIFRPRE8gbGlzdCBoYXMgYmVlbiBhZGRlZCBmb3IgaXRzCnBv
dGVudGlhbCByZS1lbmFibGVtZW50LgoKR2l2ZW4gdGhpcyB1cHN0cmVhbSBzdGF0dXMsIEkgd2ls
bCBkcm9wIG15IHYyIHBhdGNoIHN1Ym1pc3Npb24uIEEgc3RhbmRhbG9uZQpmaXggZm9yIHRoZSBp
bnRlZ2VyIG92ZXJmbG93IG5vIGxvbmdlciBhcHBsaWVzIGNsZWFubHkgd2l0aG91dCBhZGRyZXNz
aW5nCnRoZSBmdWxsIFRPRE8gbGlzdCAoaW5jbHVkaW5nIHdyaXRpbmcgdGhlIG1pc3NpbmcgSUdU
IHRlc3RzIGFuZCBoYW5kbGluZwppZHJfcHJlbG9hZCkuCgpGb3IgdGhlIG1haWxpbmcgbGlzdCBy
ZWNvcmQsIGFuZCBmb3Igd2hvZXZlciB0YWtlcyBvbiB0aGUgcmUtZW5hYmxlbWVudAp0YXNrIGlu
IHRoZSBmdXR1cmUsIEkgd2FudCB0byBsZWF2ZSBteSBsb2NhbCBmaW5kaW5ncyBoZXJlIHJlZ2Fy
ZGluZyB0aGUKZWRnZSBjYXNlczoKCjEuIFNpZ25lZCBJbnRlZ2VyIE92ZXJmbG93IGluIGlkcl9h
bGxvYzoKVGhlIG9yaWdpbmFsIGBhcmdzLT5uZXdfaGFuZGxlID4gSU5UX01BWGAgY2hlY2sgaXMg
aW5zdWZmaWNpZW50LiBJZgpgbmV3X2hhbmRsZWAgaXMgZXhhY3RseSBgSU5UX01BWGAsIHRoZSBz
dWJzZXF1ZW50IGNhbGwgdG8gYGlkcl9hbGxvYygpYAp1c2luZyBgaGFuZGxlICsgMWAgYXMgdGhl
IGVuZCBsaW1pdCB3aWxsIHJlc3VsdCBpbiBhIHNpZ25lZCBpbnRlZ2VyIG92ZXJmbG93CigtMjE0
NzQ4MzY0OCkuIFRoZSBib3VuZGFyeSBjaGVjayBtdXN0IGJlIHRpZ2h0ZW5lZCB0byBgPj0gSU5U
X01BWGAuCgoyLiBUaGUgIjAiIEhhbmRsZSBTZW1hbnRpY3MgKFRPRE8gIzMpOgpUaGUgb3JpZ2lu
YWwgY29kZSBkaWQgbm90IHJlamVjdCBoYW5kbGUgMC4gSW4gdGhlIERSTSBzdWJzeXN0ZW0sIDAg
aXMKdW5pdmVyc2FsbHkgdHJlYXRlZCBhcyBhbiBpbnZhbGlkIGhhbmRsZSAoZS5nLiwgYGRybV9n
ZW1fb2JqZWN0X2xvb2t1cGAKcmV0dXJucyBOVUxMKS4gQWxsb3dpbmcgYW4gb2JqZWN0IHRvIGJl
IGFsaWFzZWQgdG8gaGFuZGxlIDAgYnJlYWtzIGNvcmUKRFJNIHN0YXRlIGFzc3VtcHRpb25zLiBB
biBleHBsaWNpdCBgYXJncy0+bmV3X2hhbmRsZSA9PSAwYCBjaGVjayBpcwptYW5kYXRvcnkuCgpU
aGFuayB5b3UgVGhvbWFzIGFuZCB0aGUgcmV2aWV3ZXJzIGZvciB5b3VyIHRpbWUgYW5kIHRoZSBp
bnNpZ2h0ZnVsCmRpc2N1c3Npb25zLiBJIHdpbGwgbW92ZSBvbiB0byBvdGhlciBzZWN1cml0eSBy
ZXNlYXJjaCB0YXJnZXRzLgoKVGhhbmtzLApNaW5neXUKCgo=
