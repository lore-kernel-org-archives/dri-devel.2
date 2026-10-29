Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9E606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.a=rsa-sha256 header.s=default header.b=X/fq+jut
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324ED1121EA;
	Thu, 29 Oct 2026 10:51:59 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Thu, 29 Oct 2026 08:24:29 UTC
Received: from mail-m1053.netease.com (mail-m1053.netease.com [154.81.10.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F8911209B
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:24:29 +0000 (UTC)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AD6AfwDkLPJWAKFimg*tgar*.1.1793261964318.Hmail.242270054@hdu.edu.cn>
To: zack.rusin@broadcom.com
Cc: gregkh@linuxfoundation.org, bcm-kernel-feedback-list@broadcom.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 security@kernel.org
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vdm13Z2Z4OiB1bnBpbiBCT3Mgd2l0aG91dCByZXZhbGlkYXRpbmcgcGxhY2VtZW50?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: from 242270054@hdu.edu.cn( [218.75.123.175] ) by ajax-webmail (
 [127.0.0.1] ) ; Thu, 29 Oct 2026 16:19:24 +0800 (GMT+08:00)
From: =?UTF-8?B?5r2Y54Wc5p2t?= <panyuhang@hdu.edu.cn>
Date: Thu, 29 Oct 2026 16:19:24 +0800 (GMT+08:00)
X-HM-Tid: 0aa186bac03bd45akusy7a6b56a312e12
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEJDVkIaQktCTR9OGh1JSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVTE5VSklIVUpMTllXWRYaDxIVHRRZQVlPS0hVSk
 tJQkNDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
 b=X/fq+jutDqdpd7dNfe1D/0S52k8onamBZvxWSjRQGfDau2XrsnSv3sLIef0RkmQNj+YLylyn5XU+uQpEGtyE++qu5sNFnvXAEGUDpDJR1zKeGur6VWCBVjfueU2xTohd9cfVmrXO/7zvFnzlVGVk8k6QaS4Jn0wMUv4SvAbLGAc=;
 c=relaxed/relaxed; s=default; d=hdu.edu.cn; v=1; 
 bh=N410HI7U1qibEUOQj2NPQwYjw8uFNvgtaX0HyQyiGEg=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Thu, 29 Oct 2026 10:51:56 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,T_SPF_TEMPERROR
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ClVucGlubmluZyBhIGJ1ZmZlciBvYmplY3QgZG9lcyBub3QgY2hhbmdlIGl0cyBtZW1vcnkgcGxh
Y2VtZW50LgpQbGFjZW1lbnQgcmV2YWxpZGF0aW9uIGlzIHVubmVjZXNzYXJ5LiBDdXJyZW50bHkK
dm13X2JvX3Bpbl9yZXNlcnZlZCgpIGNhbGxzIHR0bV9ib192YWxpZGF0ZSgpIGZvciBib3RoIHBp
biBhbmQgdW5waW4Kb3BlcmF0aW9ucyBhbmQgdHJlYXRzIGFueSB2YWxpZGF0aW9uIGVycm9yIGFz
IGltcG9zc2libGUgd2l0aCBCVUdfT04oKS4KCkR1cmluZyBQUklNRS9HRU0gY2xlYW51cCwgdm13
X2dlbV9vYmplY3RfdW5waW4oKSBjYWxscwp2bXdfYm9fcGluX3Jlc2VydmVkKHZibywgZmFsc2Up
LiBUaGUgTGludXggNy4zLWJhc2VkIFFFTVUgcmVwcm9kdWNlcgpjb25maXJtZWQgdGhhdCB0dG1f
Ym9fdmFsaWRhdGUoKSByZXR1cm5lZCAtRUlOVkFMLiBUaGUgZm9sbG93aW5nIEJVR19PTigpCmNy
YXNoZWQgdGhlIGtlcm5lbCBkdXJpbmcgcHJvY2VzcyBleGl0LsKgCgpUaGUgcmVsZXZhbnQgcmVw
b3J0IGV4Y2VycHQgaXM6CgrCoCBbwqAgwqA3Mi45MTYxNDddIFtCT19QSU5fVFJBQ0VdIGJlZm9y
ZS12YWxpZGF0ZSBwaW49MCBvbGRfbWVtX3R5cGU9MCB0YXJnZXRfbWVtX3R5cGU9MCBmbGFncz0w
eDEwCsKgIFvCoCDCoDcyLjkxNjIwMV0gW0JPX1BJTl9UUkFDRV0gYWZ0ZXItdmFsaWRhdGUgcmV0
PS0yMiBvbGRfbWVtX3R5cGU9MCBuZXdfbWVtX3R5cGU9MCAuLi4KwqAgW8KgIMKgNzIuOTE4ODQx
XSBrZXJuZWwgQlVHIGF0IGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2JvLmM6MzQyIQrC
oCBbwqAgwqA3Mi45MTg4OTJdIE9vcHM6IGludmFsaWQgb3Bjb2RlOiAwMDAwIFsjMV0gU01QIE5P
UFRJCsKgIFvCoCDCoDcyLjkzMzI5Ml0gQ1BVOiAxIFVJRDogMCBQSUQ6IDM0NiBDb21tOiByZXBy
b192bXdnZnhfYm8KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOb3QgdGFpbnRlZCA3LjMuMC1kaXJ0
eSAjMiBQUkVFTVBUKGxhenkpCsKgIFvCoCDCoDcyLjkzNzkxMl0gUklQOiAwMDEwOnZtd19ib19w
aW5fcmVzZXJ2ZWQrMHgzNmQvMHgzODAKwqAgW8KgIMKgNzIuOTQ3MjM1XSBSQlA6IDAwMDAwMDAw
ZmZmZmZmZWEKwqAgW8KgIMKgNzIuOTkwMjU0XSBGaXhpbmcgcmVjdXJzaXZlIGZhdWx0IGJ1dCBy
ZWJvb3QgaXMgbmVlZGVkIQoKVGhlIHJlcHJvZHVjZXIgY3JlYXRlZCBhIGR1bWIgR0VNIGJ1ZmZl
ciwgZXhwb3J0ZWQvaW1wb3J0ZWQgaXRzIFBSSU1FIGZkLApwZXJmb3JtZWQgR0VNIGZsaW5rL29w
ZW4vY2xvc2Ugb3BlcmF0aW9ucywgYW5kIGV4aXRlZC4gRHVyaW5nIGV4aXRfZ3JvdXAoKSwKdGhl
IGNhbGwgcGF0aCB3YXMgdm13X2dlbV9vYmplY3RfdW5waW4oKSAtPiBkcm1fZ2VtX21hcF9kZXRh
Y2goKSAtPgpkbWFfYnVmX2RldGFjaCgpIC0+IGRybV9wcmltZV9nZW1fZGVzdHJveSgpIC0+IGRy
bV9nZW1fc2htZW1fcmVsZWFzZSgpIC0+CnZtd19ib19waW5fcmVzZXJ2ZWQoKS4KClRoZSBmaXgg
c2tpcHMgdHRtX2JvX3ZhbGlkYXRlKCkgd2hlbiB1bnBpbm5pbmcuIFZhbGlkYXRpb24gcmVtYWlu
cyBvbiB0aGUKcGluIHBhdGggYmVmb3JlIHR0bV9ib19waW4oKS4KCkFzc2lzdGVkLWJ5OiBPcGVu
QUkgQ29kZXggKEdQVC01KQpTaWduZWQtb2ZmLWJ5OiBZdWhhbmcgUGFuIDwyNDIyNzAwNTRAaGR1
LmVkdS5jbj4KLS0tCsKgZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfYm8uYyB8IDEwICsr
KysrKy0tLS0KwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2JvLmMgYi9kcml2
ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9iby5jCmluZGV4IDljN2E3M2MuLjE0ZDI4ZTIgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2JvLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfYm8uYwpAQCAtMzA4LDYgKzMwOCwxMSBAQCB2b2lkIHZt
d19ib19waW5fcmVzZXJ2ZWQoc3RydWN0IHZtd19ibyAqdmJvLCBib29sIHBpbikKwqAgwqAgwqBp
ZiAocGluID09ICEhYm8tPnBpbl9jb3VudCkKwqAgwqAgwqAgwqAgwqByZXR1cm47CsKgCivCoCDC
oCBpZiAoIXBpbikgeworwqAgwqAgwqAgwqAgdHRtX2JvX3VucGluKGJvKTsKK8KgIMKgIMKgIMKg
IHJldHVybjsKK8KgIMKgIH0KKwrCoCDCoCDCoHBsLmZwZm4gPSAwOwrCoCDCoCDCoHBsLmxwZm4g
PSAwOwrCoCDCoCDCoHBsLm1lbV90eXBlID0gYm8tPnJlc291cmNlLT5tZW1fdHlwZTsKQEAgLTMy
MSw4ICszMjYsNSBAQCB2b2lkIHZtd19ib19waW5fcmVzZXJ2ZWQoc3RydWN0IHZtd19ibyAqdmJv
LCBib29sIHBpbikKwqAKwqAgwqAgwqBCVUdfT04ocmV0ICE9IDAgfHwgYm8tPnJlc291cmNlLT5t
ZW1fdHlwZSAhPSBvbGRfbWVtX3R5cGUpOwrCoAotwqAgwqAgaWYgKHBpbikKLcKgIMKgIMKgIMKg
IHR0bV9ib19waW4oYm8pOwotwqAgwqAgZWxzZQotwqAgwqAgwqAgwqAgdHRtX2JvX3VucGluKGJv
KTsKK8KgIMKgIHR0bV9ib19waW4oYm8pOwrCoH0KCi0twqAKMi4zNC4xCgpSZWdhcmRzLApZdWhh
bmcgUGFuCjI0MjI3MDA1NEBoZHUuZWR1LmNu
