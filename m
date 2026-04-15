Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AEDF8A146
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F6C710E848;
	Thu, 16 Apr 2026 08:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=metarealtyinc-ca.20251104.gappssmtp.com header.i=@metarealtyinc-ca.20251104.gappssmtp.com header.b="ltoAS3xo";
	dkim-atps=neutral
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA4410E736
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 19:08:32 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-953a26a9abcso1984841241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metarealtyinc-ca.20251104.gappssmtp.com; s=20251104; t=1776280112;
 x=1776884912; darn=lists.freedesktop.org; 
 h=date:references:in-reply-to:subject:cc:to:from
 :content-transfer-encoding:mime-version:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7DUpKepUcTvz1aYRk2xwKoLLVYxkuA8yuF8RSnjHh4=;
 b=ltoAS3xogpdIZRXMOuFEPOH6JUtndxxbGk29d0+nuigTTP6SxWmCpWyKFKYOP0BqkP
 T4NSF542vqjI46R/1uyrcUG5+FhMn85QICXzLzj5yN3za3Q5HATqzi8XBXWmvgNyt8rW
 NfB7DLIunlzUaV9ZqZc5uuGkkmup4ie33/00OQLjBUd3AHgfnqqv7vO0YpkaHPbR7P63
 WhrH9C/444SdClpHmlSJUNf6dfQcnNaSIJ/RQf+EaoJIliqSvi1AQzIGFDgdASsgcuF0
 2NOWeL67if/MxCHNYDNei+6ieWGhTINU90NNRYwQwdKJ/Wx26gah2fqiJPfPO8Fp8dpm
 le/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776280112; x=1776884912;
 h=date:references:in-reply-to:subject:cc:to:from
 :content-transfer-encoding:mime-version:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7DUpKepUcTvz1aYRk2xwKoLLVYxkuA8yuF8RSnjHh4=;
 b=gJP4RFOSdci3LqZ6qRiGD9apwUQ2bzQbLDxMEOr5F3kYKepCr9mcaoeRhD5P2uUgUW
 rXzCraoUtdvn9WF1TaFOtGIJEDgNw9xPcrIFFiyrhzqmbxBI5HLJdFuXzOlmTgEPe8ft
 EilW6rdCD3b4XLsmCJzoXtFQKpSQrZkoflqS7kWVEA+TGE7DhSxsNL2DHYsCcfH1b5O2
 pnsgE5yuuUyyjhe7a7cPqZ/ClSiIFc8wa2PyF+bdsIyUOT1ajh63TdNKCjw9jzfFzaln
 g+55LVLwx/ah1T8paeHKdyMndT6xFf7B1AiOrUii9XY791p/xQW5HylgdJFJv2ZOPSgK
 STwg==
X-Gm-Message-State: AOJu0Yx0bHxvcYBf7GWE23PAqJe3cUSpVLu+LJbloR/jZpfkebNTSjRN
 MeIKPcw8MX+RrodHG6LVtQ/CHLmGM+W2YYNMgpyu01VwG1YcONs4Rfbo8u9E9vUYvOw=
X-Gm-Gg: AeBDievRcItOKqGYvtxOW5OuzjT6MT8qy7dLQM2Oqr7WCFLgEWhKdEBXBlQDxrobIS1
 We0HW0iqmfaqOF6X6llkctFABXvbBuNiLjxoCyaR5U/xFgo/5344xJqUCJ0TW8BIhj91roKjeni
 YZuvT2/0sTl7BADqx45GJeaJzz6lwBZ1ZllwijslwRk0CtqLTP63mxX5QyIJrfwxKTELPjMFKXS
 9QJnR5uHUKfv4If44FuG5aSCN6sByxbt6nP+IujChVqVF5uPWYJUXzxDapWEwYGXXDTQfNyrxKY
 UTxQ/J4xXQcLdPEvHUSXZ4j2nHKDvmlieE6Dtz6ysAY+/JTXK/jyqNAahdEhfEpN5d9rvEE5/VA
 qBJ+IvNS2AMcZ609mnCZ6IGf/h+vsK3Cgtioz1WuF/E5jlYdusrz+oNx/RVFtKDHsHmc7kh+ffW
 HwPa1ukey/ojse8IUzJOdkslznqTt3JjgSTDxyX60AqbO8zExE7+Wx7MNXR9uT9EUSf/E/LWZdC
 7NhxwYYZlprjxaj7I2Mc1W0pI+2k/23CcOnQBQpzSY=
X-Received: by 2002:a05:6102:1621:b0:608:6d10:e415 with SMTP id
 ada2fe7eead31-609fe9b1602mr9781543137.8.1776280111672; 
 Wed, 15 Apr 2026 12:08:31 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:e5:500:8e39:827f:e928:9eb7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6cda4fa0sm18569186d6.36.2026.04.15.12.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 12:08:31 -0700 (PDT)
Message-ID: <69dfe22f.050a0220.301b30.5755@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Jake S <j@metarealtyinc.ca>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com
Subject: Re: [PATCH 2/2] drm/i915/display: allow eDP VRR when EDID has
 adaptive sync range
In-Reply-To: <20260415130626.10523-3-j@metarealtyinc.ca>
References: <20260415130626.10523-1-j@metarealtyinc.ca>
 <20260415130626.10523-3-j@metarealtyinc.ca>
Date: Wed, 15 Apr 2026 19:08:30 +0000
X-Mailman-Approved-At: Thu, 16 Apr 2026 08:39:27 +0000
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

SGkgVmlsbGUsCgo+IEFGQUlDUyB0aGUgV2luZG93cyBkcml2ZXIgZG9lcyByZXNwZWN0IHRoYXQg
VkJUIGJpdC4gU28gd2Ugc2hvdWxkIHRvby4KClRoYXQncyBmYWlyIC0tIEkgZG9uJ3QgaGF2ZSB2
aXNpYmlsaXR5IGludG8gdGhlIFdpbmRvd3MgZHJpdmVyCmludGVybmFscyBzbyBJIGNhbid0IHNh
eSBkZWZpbml0aXZlbHkgd2hldGhlciBpdCBjaGVja3MgVkJUIG9yIG5vdC4KCldoYXQgSSBjYW4g
Y29uZmlybSBpcyB0aGUgZW5kLXVzZXIgcmVzdWx0OiBvbiB0aGlzIERlbGwgWFBTIDIwMjYKKFBh
bnRoZXIgTGFrZSksIFZSUiAyMC0xMjBIeiB3b3JrcyBvbiBXaW5kb3dzIGJ1dCBub3Qgb24gTGlu
dXggd2l0aAp0aGUgc2FtZSBmaXJtd2FyZS4gVGhlIFZCVCBkb2VzIG5vdCBjb250YWluIGEgVlJS
IGZsYWcgZm9yIHRoaXMgcGFuZWwKYXQgYWxsIC0tIGludGVsX3ZidF9kZWNvZGUgc2hvd3Mgbm8g
VlJSLXJlbGF0ZWQgZmllbGRzIGluIHRoZSBjaGlsZApkZXZpY2UgYmxvY2suCgpTbyBlaXRoZXIg
V2luZG93cyBoYXMgYSBmYWxsYmFjayBwYXRoIHdoZW4gVkJUIGRvZXNuJ3QgZGVjbGFyZSBWUlIs
Cm9yIERlbGwncyBJbnRlbCBEQ0ggZHJpdmVyIHNoaXBzIHdpdGggYSBkcml2ZXItc2lkZSBvdmVy
cmlkZS4gRWl0aGVyCndheSwgdGhlIHBhbmVsIGNsZWFybHkgc3VwcG9ydHMgVlJSICh0aGUgRURJ
RCdzIERpc3BsYXlJRCBleHRlbnNpb24KZXhwbGljaXRseSBkZWNsYXJlcyBBZGFwdGl2ZSBTeW5j
IDIwLTEyMEh6KSwgYW5kIGl0IHdvcmtzIGluIHByYWN0aWNlCm9uIHRoaXMgaGFyZHdhcmUuCgpG
cmFtZXdvcmsgbGFwdG9wIHVzZXJzIGhhdmUgcmVwb3J0ZWQgdGhlIHNhbWUgY2xhc3Mgb2YgaXNz
dWUgd2l0aAp0aGVpciBCT0UgcGFuZWxzLgoKSWYgcmVzcGVjdGluZyBWQlQgaXMgaW1wb3J0YW50
IChhbmQgSSB1bmRlcnN0YW5kIHRoZSByZWFzb25pbmcgLS0KT0VNIHZhbGlkYXRpb24pLCB3b3Vs
ZCBzb21ldGhpbmcgbGlrZSBhIHF1aXJrIHRhYmxlIG9yIGEgbW9kdWxlCnBhcmFtZXRlciBiZSBh
biBhY2NlcHRhYmxlIGFsdGVybmF0aXZlPyBJJ2QgcmF0aGVyIGhhdmUgYW55IHBhdGggdG8KbWFr
aW5nIHRoaXMgd29yayB0aGFuIG5vIHBhdGguCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCgpKYWtl
Cg==
