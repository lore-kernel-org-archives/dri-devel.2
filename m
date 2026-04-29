Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4914FFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E06A010EF32;
	Wed, 29 Apr 2026 10:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="FlCsPUvk";
	dkim-atps=neutral
X-Greylist: delayed 466 seconds by postgrey-1.36 at gabe;
 Wed, 29 Apr 2026 02:34:02 UTC
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by gabe.freedesktop.org (Postfix) with ESMTP id E583410E3A8
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 02:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stu.xidian.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
 bh=KQiK0mael7WytvHyyQY9gVLlZRI0Tue2xYz886rSOSU=; b=FlCsPUvkCKP/t
 Mzu9fyAkw60n+Lc8dRIEe3+KlmXHCzHm4X4Abl0KQWKULtF0F47AjujV1xdGB5jQ
 UirJ42d0PwQ8BlvhBisrIOxZxGMFV9idROLXgML/01aYVcV37Gl24aISgwNUVwKv
 B8PK2eGYAxkRbxxjJ0gpkF64nM6acU=
Received: from 25181214217$stu.xidian.edu.cn ( [113.200.174.80] ) by
 ajax-webmail-hzbj-edu-front-4.icoremail.net (Coremail) ; Wed, 29 Apr 2026
 10:33:50 +0800 (GMT+08:00)
X-Originating-IP: [113.200.174.80]
Date: Wed, 29 Apr 2026 10:33:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?546L5piO54Wc?= <25181214217@stu.xidian.edu.cn>
To: dri-devel@lists.freedesktop.org
Cc: "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] agp: amd64: fix null-ptr-deref in amd64_fetch_size
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250410(2f5ccd7f) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <45f753f9.9a8c.19dd715ea5a.Coremail.25181214217@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: BrQMCkAGrbgPbvFpxILTAQ--.45321W
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUSEWnwzuZQN
	QACsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

RHVyaW5nIHRoZSBpbml0aWFsaXphdGlvbiBvZiB0aGUgYW1kNjRfYWdwIGRyaXZlciwgdGhlIGBh
bWQ2NF9mZXRjaF9zaXplKClgCmZ1bmN0aW9uIGF0dGVtcHRzIHRvIHJldHJpZXZlIHRoZSBQQ0kg
ZGV2aWNlIHBvaW50ZXIgZnJvbSB0aGUgQU1ECm5vcnRoYnJpZGdlIGRlc2NyaXB0b3IuCgpUaGUg
Y29kZSBhc3N1bWVzIHRoYXQgYSB2YWxpZCBBTUQgbm9ydGhicmlkZ2UgYWx3YXlzIGV4aXN0cyB3
aGVuIHRoaXMKZHJpdmVyIGlzIHByb2JlZDoKCWRldiA9IG5vZGVfdG9fYW1kX25iKDApLT5taXNj
OwoKSG93ZXZlciwgaW4gbWl4ZWQgb3IgZW11bGF0ZWQgZW52aXJvbm1lbnRzIChlLmcuLCBhbiBJ
bnRlbCBDUFUgZW52aXJvbm1lbnQKd2l0aCBhbiBBTUQgQUdQIGJyaWRnZSBwYXNzZWQgdGhyb3Vn
aCBvciBlbXVsYXRlZCksIGBub2RlX3RvX2FtZF9uYigwKWAKd2lsbCByZXR1cm4gTlVMTC4gVGhp
cyBsZWFkcyB0byBhbiBpbW1lZGlhdGUgbnVsbC1wb2ludGVyIGRlcmVmZXJlbmNlCndoZW4gYXR0
ZW1wdGluZyB0byBhY2Nlc3MgYC0+bWlzY2AsIGNhdXNpbmcgYSBrZXJuZWwgcGFuaWMuCgpGaXgg
dGhpcyBieSBwcm9wZXJseSBjaGVja2luZyB0aGUgcmV0dXJuIHZhbHVlIG9mIGBub2RlX3RvX2Ft
ZF9uYigpYApiZWZvcmUgZGVyZWZlcmVuY2luZyBpdC4KClNpZ25lZC1vZmYtYnk6IE1pbmd5dSBX
YW5nIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4KLS0tCiBkcml2ZXJzL2NoYXIvYWdw
L2FtZDY0LWFncC5jIHwgOSArKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2FncC9hbWQ2NC1h
Z3AuYyBiL2RyaXZlcnMvY2hhci9hZ3AvYW1kNjQtYWdwLmMKaW5kZXggMjUwNWRmMWY0ZTY5Li4x
YzIxNzg3ZGVkNjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci9hZ3AvYW1kNjQtYWdwLmMKKysr
IGIvZHJpdmVycy9jaGFyL2FncC9hbWQ2NC1hZ3AuYwpAQCAtMTI0LDkgKzEyNCwxNCBAQCBzdGF0
aWMgaW50IGFtZDY0X2ZldGNoX3NpemUodm9pZCkKIAlpbnQgaTsKIAl1MzIgdGVtcDsKIAlzdHJ1
Y3QgYXBlcl9zaXplX2luZm9fMzIgKnZhbHVlczsKKwlzdHJ1Y3QgYW1kX25vcnRoYnJpZGdlICpu
YjsKIAotCWRldiA9IG5vZGVfdG9fYW1kX25iKDApLT5taXNjOwotCWlmIChkZXY9PU5VTEwpCisJ
bmIgPSBub2RlX3RvX2FtZF9uYigwKTsKKwlpZiAoIW5iKQorCQlyZXR1cm4gMDsKKworCWRldiA9
IG5iLT5taXNjOworCWlmICghZGV2KQogCQlyZXR1cm4gMDsKIAogCXBjaV9yZWFkX2NvbmZpZ19k
d29yZChkZXYsIEFNRDY0X0dBUlRBUEVSVFVSRUNUTCwgJnRlbXApOwotLSAKMi4zNC4xCg==
