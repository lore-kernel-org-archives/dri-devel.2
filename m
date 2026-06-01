Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B729CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 07:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9C3112ED7;
	Mon,  1 Jun 2026 07:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sJ9T4oiJ";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84E3112CB6
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 00:44:07 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-304e58292d3so5579661eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 17:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780274647; cv=none;
 d=google.com; s=arc-20240605;
 b=PgsG7vW3cLygbDy/dl/cVvC8GGi/FdtozAP4k7dMekXLbeRXuKeU3/lGnPbEVzRwsr
 g0Tpf2IGAI7m1ASxqZfB1ifjfGtIYL0uylBZjQ+EelFXmnQwUKyuqX3lcoaNN58WwwFX
 IchBOIyDnuclzZ9/HW5k/k1eloziEVZD8DtqIOUlE+mk5smbX0YtscKImrvOTze21JzS
 0oLmmlNClvj9/+dfsXoM/PGeyNlrekAuYFXv7hLstcf8jZ6vI86ZELTu9EpiUNuvQE5/
 BZPrDZjK7bwfC1P7RQH0qeEZikeqlapjWh/HKYb06a0cbSVgDrLFira4BngDDBSB/53F
 YgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=St8SQ1gSdmWTKrF8sfCTlvEzF6I8dA72iftkS3Fg46I=;
 fh=dQwtDvXN9UcCGBVXEm31XtUNBNzr6Jnw8VuM7Dtq5tA=;
 b=MC4Gvj0Ll7kA2kflgxZ2HZPDNhBysAzGG1EA4BgavGQabxspc7j+jLwo6tAMV8eQhb
 ClL6kEX2v15j1hwAWwn2eVwUPSc3w79pQKxiZNIkgFD6Gu7miDJiqHsuSVbCqqJsTBZK
 r0324s0i1Agn6TcAgdJwx4ZCkTqN/w+qqfIm+LjtKNReFKK42PbhJmKn0Me4NSKNIvAT
 VohcMYe3Yqpb0RNK/LEmbTN9HJZ6lcJsuo7BRx0r/D11jSdC4KYPqz2GXxLyGjlcdOfL
 SFGmtNAOJAafJEOIgFB28oB+DFsnjwdwl+S3MbtNSEd698MUVtXqr6Pn+8EXDE4igVnd
 3aPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780274647; x=1780879447; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=St8SQ1gSdmWTKrF8sfCTlvEzF6I8dA72iftkS3Fg46I=;
 b=sJ9T4oiJ7aNeNAPR3DM6V0Ce3VEIAzeALrLW0pUVfyMo9hE4a6wSHvCNhlM2VJ6n3s
 yFbiuLFD1HEtD1G1lxUuNheQ0XDRPR9uzvImpa2qnMr+Ncx+FpoeaXGibSohvvZQNV5j
 PynRWA/Bu6wVDBkYKQAUE2rMCGrI5e8/28qsR1xRtyz4ijbpva/C04fq9/K+iWIVEE+J
 KSfWst6vC2aB+rU5Y3eHgI5IzAxEpAB5QLIHTziw1OWQkqx7EJZUlm9c8QYBO8hkwx+o
 DSQvu7MmLur8bPNMDJaa+JjFVWSiTAWJLGcjyY/kQefu3NKnWVCGOjT1nSVy0JeL8JSl
 K88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780274647; x=1780879447;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=St8SQ1gSdmWTKrF8sfCTlvEzF6I8dA72iftkS3Fg46I=;
 b=YjKSyHkY2md5s8kBFLY+HELa7QN2GYBXHg8ZmBOXb9obYs4GqPNpY6/OZ9bi80YiPO
 5BvCp9qCPqpG6sDrAPL+PinCkNLfTKPDeZq+V/Nacf6v2xXii4hlVMy/78NfqHFIjjiH
 7iZXMg82ZJx49Y/69boLcSpttaA+TxFAUlhM7yBGoim3jqee/MdIw2+4tS/jt/kd6a4f
 NgOLCPwjxE68u9aipTZIl8lYkRj0Z9VB0KbWbvSdXdkg5+vpe+f5pLoQvu+R0czbQNmo
 bqi9NW9Ah+HZ2btFq67ioJUaSK97x0+bz6DM6DnfKL5G4Yw4Y6atKEdgubCGBGIWWQBR
 moIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HUHYEo1oxW3YmilXn95++iIThQIcq42h6/aM0gV1/xfHe4Wyc2h4ReVa/0MXUGDPNm/uJeM9KPKI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYNbpsHoc2TaeJ63NnuHHR3JcryZ9RokheidyvUxjMKtJvS+RG
 f8YOGr/r+PX3Dolchu2kIzk+aFChssA1gPqVKCfL9CPEJz9Gmqj5Q52PzzsZUrc0bbHB3l5SSY2
 tgnpW/y48TqKELdS4c6oiDfEpfzL13io=
X-Gm-Gg: Acq92OHWahCNg9jdc4ck72y2cspNbgzwVB/pOuCzrDP40z7DFXa3njhjAEXPYUHWE6j
 yVV/AlSdhJf05ScWYJOGzqyvkY2UD7RBMfdu565ljo5BriJHluAHIYhP491Pwd7EjZug6hv9Fbq
 Y3NeAmL5ctDpdDqGAf8llaa5c2dHJuvY1BgJwclaapjt5IA0+QzuXnmq8s+eyB03OXQAvzrHM4z
 +a8t4gbjCTmJiYENDCN0s0QFHssqhEixIU800Ay4BxObsXXll0+8+U4YcSvA/iXKZ3Ph3A4DtK0
 2se3w5344MRMueiHQkUmebz7jcim
X-Received: by 2002:a05:7300:6c84:b0:2d8:97d6:6abc with SMTP id
 5a478bee46e88-304fa67401amr4424101eec.22.1780274646888; Sun, 31 May 2026
 17:44:06 -0700 (PDT)
MIME-Version: 1.0
From: Enchanted Hunter <enchantedredhunter@gmail.com>
Date: Mon, 1 Jun 2026 03:43:55 +0300
X-Gm-Features: AVHnY4KBQe9-bwOHL2irZGJ83_sz5c6ViVOpW031dRkTwC4Ae5gAftJCTsj2gxE
Message-ID: <CAOSULec2OpwTGB3OUb_n3CdKO6H_DGJnxw=qsBswbd+JBjemKA@mail.gmail.com>
Subject: [PATCH] staging: fbtft: replace sprintf with snprintf
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, andy@kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="000000000000eeb4ee0653267d0a"
X-Mailman-Approved-At: Mon, 01 Jun 2026 07:27:00 +0000
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

--000000000000eeb4ee0653267d0a
Content-Type: multipart/alternative; boundary="000000000000eeb4ec0653267d08"

--000000000000eeb4ec0653267d08
Content-Type: text/plain; charset="UTF-8"

This patch replaces unsafe sprintf calls with snprintf
infbtft_register_framebuffer() to prevent potential buffer
overflow.Signed-off-by: rat1bor <enchantedredhunter@gmail.com>

--000000000000eeb4ec0653267d08
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><pre><span>This patch replaces unsafe sprintf calls with snprintf in</span>
<span>fbtft_register_framebuffer() to prevent potential buffer overflow.</span>
<span></span>
<span>Signed-off-by: rat1bor &lt;<a href="mailto:enchantedredhunter@gmail.com">enchantedredhunter@gmail.com</a>&gt;</span></pre></div>

--000000000000eeb4ec0653267d08--

--000000000000eeb4ee0653267d0a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-staging-fbtft-replace-sprintf-with-snprintf.patch"
Content-Disposition: attachment; 
	filename="0001-staging-fbtft-replace-sprintf-with-snprintf.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mpuhh6ek0>
X-Attachment-Id: f_mpuhh6ek0

RnJvbSBhNzljNjA5OGYyZThiYjJlZTllMjc2ZDMzOTcxMDUyMjE3NWRiOTc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiByYXQxYm9yIDxlbmNoYW50ZWRyZWRodW50ZXJAZ21haWwuY29t
PgpEYXRlOiBNb24sIDEgSnVuIDIwMjYgMDM6MTg6NTkgKzAzMDAKU3ViamVjdDogW1BBVENIXSBz
dGFnaW5nOiBmYnRmdDogcmVwbGFjZSBzcHJpbnRmIHdpdGggc25wcmludGYKClNpZ25lZC1vZmYt
Ynk6IHJhdDFib3IgPGVuY2hhbnRlZHJlZGh1bnRlckBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9z
dGFnaW5nL2ZidGZ0L2ZidGZ0LWNvcmUuYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdp
bmcvZmJ0ZnQvZmJ0ZnQtY29yZS5jIGIvZHJpdmVycy9zdGFnaW5nL2ZidGZ0L2ZidGZ0LWNvcmUu
YwppbmRleCBjYTBjMzgyMjFjMTYuLjY2NTA5MzQ3MjU1YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9z
dGFnaW5nL2ZidGZ0L2ZidGZ0LWNvcmUuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvZmJ0ZnQvZmJ0
ZnQtY29yZS5jCkBAIC03ODQsMTAgKzc4NCwxMSBAQCBpbnQgZmJ0ZnRfcmVnaXN0ZXJfZnJhbWVi
dWZmZXIoc3RydWN0IGZiX2luZm8gKmZiX2luZm8pCiAJZmJ0ZnRfc3lzZnNfaW5pdChwYXIpOwog
CiAJaWYgKHBhci0+dHhidWYuYnVmICYmIHBhci0+dHhidWYubGVuID49IDEwMjQpCi0JCXNwcmlu
dGYodGV4dDEsICIsICV6dSBLaUIgYnVmZmVyIG1lbW9yeSIsIHBhci0+dHhidWYubGVuID4+IDEw
KTsKKwkJc25wcmludGYodGV4dDEsIHNpemVvZih0ZXh0MSksICIsICV6dSBLaUIgYnVmZmVyIG1l
bW9yeSIsIHBhci0+dHhidWYubGVuID4+IDEwKTsKIAlpZiAoc3BpKQotCQlzcHJpbnRmKHRleHQy
LCAiLCBzcGklZC4lZCBhdCAlZCBNSHoiLCBzcGktPmNvbnRyb2xsZXItPmJ1c19udW0sCi0JCQlz
cGlfZ2V0X2NoaXBzZWxlY3Qoc3BpLCAwKSwgc3BpLT5tYXhfc3BlZWRfaHogLyAxMDAwMDAwKTsK
KwkJc25wcmludGYodGV4dDIsIHNpemVvZih0ZXh0MiksICIsIHNwaSVkLiVkIGF0ICVkIE1IeiIs
CisJCQkgc3BpLT5jb250cm9sbGVyLT5idXNfbnVtLCBzcGlfZ2V0X2NoaXBzZWxlY3Qoc3BpLCAw
KSwKKwkJCSBzcGktPm1heF9zcGVlZF9oeiAvIDEwMDAwMDApOwogCWZiX2RiZyhmYl9pbmZvLAog
CSAgICAgICAiJXMgZnJhbWUgYnVmZmVyLCAlZHglZCwgJWQgS2lCIHZpZGVvIG1lbW9yeSVzLCBm
cHM9JWx1JXNcbiIsCiAJICAgICAgIGZiX2luZm8tPmZpeC5pZCwgZmJfaW5mby0+dmFyLnhyZXMs
IGZiX2luZm8tPnZhci55cmVzLAotLSAKMi4zNC4xCgo=
--000000000000eeb4ee0653267d0a--
