Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950D606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.a=rsa-sha256 header.s=default header.b=gNB2O+kf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FEC610E80E;
	Thu, 29 Oct 2026 10:51:57 +0000 (UTC)
Received: from mail-m10199.netease.com (mail-m10199.netease.com
 [154.81.10.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D75110E287
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:33:17 +0000 (UTC)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ACEAWQCGLEhWF5vMItAIpqoW.1.1793262795047.Hmail.242270054@hdu.edu.cn>
To: zack.rusin@broadcom.com
Cc: gregkh@linuxfoundation.org, bcm-kernel-feedback-list@broadcom.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 security@kernel.org
Subject: =?UTF-8?B?cmVqZWN0IFBSSU1FIGV4cG9ydCB3aXRob3V0IFRUTSBiYWNraW5n?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: from 242270054@hdu.edu.cn( [218.75.123.175] ) by ajax-webmail (
 [127.0.0.1] ) ; Thu, 29 Oct 2026 16:33:15 +0800 (GMT+08:00)
From: =?UTF-8?B?5r2Y54Wc5p2t?= <panyuhang@hdu.edu.cn>
Date: Thu, 29 Oct 2026 16:33:15 +0800 (GMT+08:00)
X-HM-Tid: 0aa186cab927d45akusy85d7ca4c12f59
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkgaVkIeGk8YS0xJQ04fSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVTE5VSklIVUpMTllXWRYaDxIVHRRZQVlPS0hVSk
 tJQkNDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
 b=gNB2O+kfFOfjbORRt2JXDQSLKH++NkmqYSe2MK7LgW3K+hN65Jn3dK/hKCTx2jsE2sj5qnqrOGPrPYi1O2oOZneK9ZyP1q1blFKGVfWleC6xcbhw+AnZdrgAEglPfNqLRP3R6n0/kt2aiGdbu3pGhdHuCkJKL6VA5sh4tek+81M=;
 c=relaxed/relaxed; s=default; d=hdu.edu.cn; v=1; 
 bh=ugUIMCjMxxqgsLH2sZshzVPxfok+Qgx/R9/1tAMlkvE=;
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
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGVsbG8sCgpHUFQtNSBhc3Npc3RlZCB3aXRoIHRoZSBpbml0aWFsIGFuYWx5c2lzIGFuZCBkcmFm
dGluZyB0aGUgcHJvcG9zZWQgZml4LiBJIGFtCnJlc3BvbnNpYmxlIGZvciB0aGlzIHJlcG9ydCBh
bmQgcGF0Y2guCgpXaGlsZSBmdXp6aW5nIHRoZSB2bXdnZnggUFJJTUUgaW1wb3J0IHBhdGgsIEkg
b2JzZXJ2ZWQgYSBrZXJuZWwgTlVMTCBwb2ludGVyCmRlcmVmZXJlbmNlIGluIHZtd19nZW1fb2Jq
ZWN0X2dldF9zZ190YWJsZSgpLiBUaGUgdXNlcnNwYWNlIG9wZXJhdGlvbiB3YXMKRFJNX0lPQ1RM
X1BSSU1FX0ZEX1RPX0hBTkRMRS4gVGhlIGNhbGwgcGF0aCB3YXM6CgogIF9feDY0X3N5c19pb2N0
bCgpCiAgICAtPiB2bXdfdW5sb2NrZWRfaW9jdGwoKQogICAgLT4gdm13X2dlbmVyaWNfaW9jdGwo
KQogICAgLT4gZHJtX2lvY3RsKCkKICAgIC0+IGRybV9wcmltZV9mZF90b19oYW5kbGVfaW9jdGwo
KQogICAgLT4gdm13X3ByaW1lX2ZkX3RvX2hhbmRsZSgpCiAgICAtPiBkcm1fZ2VtX3ByaW1lX2Zk
X3RvX2hhbmRsZSgpCiAgICAtPiBkcm1fZ2VtX3ByaW1lX2ltcG9ydF9kZXYoKQogICAgLT4gZG1h
X2J1Zl9tYXBfYXR0YWNobWVudCgpCiAgICAtPiBkcm1fZ2VtX21hcF9kbWFfYnVmKCkKICAgIC0+
IHZtd19nZW1fb2JqZWN0X2dldF9zZ190YWJsZSgpCgpUaGUgdm13Z2Z4IGNhbGxiYWNrIG9idGFp
bnMgdGhlIFRUTSBidWZmZXIgb2JqZWN0IGFuZCB1c2VzIGJvLT50dG0gYXMgdGhlCmVtYmVkZGVk
IGRtYV90dG0gbWVtYmVyIG9mIHN0cnVjdCB2bXdfdHRtX3R0LiBJbiB0aGUgY3Jhc2hpbmcgcGF0
aCwgYm8tPnR0bQp3YXMgTlVMTC4gY29udGFpbmVyX29mKCkgY29uc2VxdWVudGx5IHByb2R1Y2Vk
IGEgTlVMTC1iYXNlZCB2bXdfdHRtX3R0CnBvaW50ZXIsIGFuZCByZWFkaW5nIHZtd190dC0+dnNn
dC5zZ3QgZmF1bHRlZCBhdCBvZmZzZXQgMHg4ODoKCiAgQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDg4CiAgUklQOiAwMDEwOnZtd19n
ZW1fb2JqZWN0X2dldF9zZ190YWJsZSsweDJmLzB4YTAKICBSQlA6IDAwMDAwMDAwMDAwMDAwMDAK
ICBDUjI6IDAwMDAwMDAwMDAwMDAwODgKClRoZSBmYXVsdGluZyBpbnN0cnVjdGlvbiByZWFkcyBm
cm9tIFtSQlAgKyAweDg4XTsgd2l0aCBSQlAgZXF1YWwgdG8gemVybywKdGhpcyBtYXRjaGVzIHRo
ZSByZXBvcnRlZCBhZGRyZXNzLiBUaGUgY2FsbGJhY2sgcmVxdWlyZXMgYSB2bXdnZnggVFRNCnRy
YW5zbGF0aW9uIHRhYmxlLCBzbyBpdCBtdXN0IHJlamVjdCBhbiBvYmplY3Qgd2l0aG91dCBiby0+
dHRtIGJlZm9yZQpjb250YWluZXJfb2YoKSBhbmQgbWVtYmVyIGFjY2Vzcy4gVGhpcyBwYXRjaCBy
ZXR1cm5zIC1FSU5WQUwgaW4gdGhhdCBjYXNlLgoKVGhlIHBhdGNoIGJlbG93IGlzIGFnYWluc3Qg
dGhlIExpbnV4IDcuMyBzb3VyY2UgdHJlZTsgaXQKYXBwbGllcyBjbGVhbmx5IGFuZCBwYXNzZXMg
Y2hlY2twYXRjaC5wbCAtLXN0cmljdC4KCkFzc2lzdGVkLWJ5OiBPcGVuQUkgQ29kZXggKEdQVC01
KQpTaWduZWQtb2ZmLWJ5OiBZdWhhbmcgUGFuIDwyNDIyNzAwNTRAaGR1LmVkdS5jbj4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9nZW0uYyB8IDggKysrKysrLS0KIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4
L3Ztd2dmeF9nZW0uYwppbmRleCAzOWY4YzQ2Li5kZDFlNmI3IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9nZW0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4
L3Ztd2dmeF9nZW0uYwpAQCAtNzAsOCArNzAsMTIgQEAgc3RhdGljIHZvaWQgdm13X2dlbV9vYmpl
Y3RfdW5waW4oc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmopCiBzdGF0aWMgc3RydWN0IHNnX3Rh
YmxlICp2bXdfZ2VtX29iamVjdF9nZXRfc2dfdGFibGUoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpv
YmopCiB7CiAJc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibyA9IGRybV9nZW1fdHRtX29mX2dl
bShvYmopOwotCXN0cnVjdCB2bXdfdHRtX3R0ICp2bXdfdHQgPQotCQljb250YWluZXJfb2YoYm8t
PnR0bSwgc3RydWN0IHZtd190dG1fdHQsIGRtYV90dG0pOworCXN0cnVjdCB2bXdfdHRtX3R0ICp2
bXdfdHQ7CisKKwlpZiAodW5saWtlbHkoIWJvLT50dG0pKQorCQlyZXR1cm4gRVJSX1BUUigtRUlO
VkFMKTsKKworCXZtd190dCA9IGNvbnRhaW5lcl9vZihiby0+dHRtLCBzdHJ1Y3Qgdm13X3R0bV90
dCwgZG1hX3R0bSk7CiAKIAlpZiAodm13X3R0LT52c2d0LnNndCkKIAkJcmV0dXJuIHZtd190dC0+
dnNndC5zZ3Q7Ci0tIAoyLjM0LjEKClJlZ2FyZHMsCll1aGFuZyBQYW4KMjQyMjcwMDU0QGhkdS5l
ZHUuY24K
