Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06164F8A146
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFFC10E843;
	Thu, 16 Apr 2026 08:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=metarealtyinc-ca.20251104.gappssmtp.com header.i=@metarealtyinc-ca.20251104.gappssmtp.com header.b="NDk/fgZQ";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEA210E18F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 19:39:14 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-50baafd6c4aso74045101cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metarealtyinc-ca.20251104.gappssmtp.com; s=20251104; t=1776281953;
 x=1776886753; darn=lists.freedesktop.org; 
 h=date:references:in-reply-to:subject:cc:to:from
 :content-transfer-encoding:mime-version:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBFBxNBSTTxIBo6jQ9Ed1NU8hv/XV5Shu7D1Vz0KsLg=;
 b=NDk/fgZQB9mAcCJC5WWS7vMmBbDQz5K31xxK783WnHdGNS2hpyNzXdZOh6HpLHCeJG
 EBWlLLT4MW2mdnVxe6SkLxi6END/Mvnsq2xITthwwTM5UzIy3P4RGafV68YiaQpzyDVC
 4hPThha0Ols1qpi38HINVuIxPbC/A3n2R5OckP/gSuYAlXYlHRrRCZ56uoB4fm5/rzqX
 bS1DCTwnUy+2fICrv1rn1MNwBiw2hJuHJ44FIPaAAwWS9k/f/qh8ODPlkvqZNFVTxndG
 42eEoqwuPZF+ry7ud0JXwXL54TlKc1VTPyNQUDSPQIk+9+5n+CiU9l9K8lcwksxpDShm
 oBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776281953; x=1776886753;
 h=date:references:in-reply-to:subject:cc:to:from
 :content-transfer-encoding:mime-version:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OBFBxNBSTTxIBo6jQ9Ed1NU8hv/XV5Shu7D1Vz0KsLg=;
 b=qvyERxYUB5hTQ2EcTf6vEdTD6Ct/PrIHnFGFcQHXt3oTy7UgRzuRV0hAV7Mc+y5HWG
 8sFP/RplyepNTz8XWIXtHmD5Ulv+FU/EzT5BpQLmWsGHdpvasv8TrtxkHthow6qHNjEy
 50/LTnZ2cK4xI+s7JcNNMMORhEBr6YXKQDoAEgYxcOvcQqTlz1uOC5uRMoqgNAV1Aln9
 bRTNEDJmIb6EjP3asElLecjDFQu3zHTqhKXu22I2lh4KUVycaXduyhCpgHTdTLH2TnUB
 2dHF+9zTZPQRAVT9eqJjckK6FxEThbMBMWxFiP63wwDrfDvU2CbjO6VeXYd0IEMe8nok
 RofQ==
X-Gm-Message-State: AOJu0Yz7FK55iQogIVjVHlNeF7bXPRnAjB1nQJQQwj2NS/p5lI+j7IqM
 WeQxEib+K5FCLodNcBCBJx5Uxt/8IQTGO1S1hlZHLq2QnHUdkPXLoCQSxjYWnmUMzmz47ji24Vg
 TeSh2CI0=
X-Gm-Gg: AeBDiet883vb1yaC1F4RTof4EKrenLrBnvQpzRdtG7UXRejjYfFbMg+KdH3WAzHpPvj
 jNl/6cWtTrBIiBOMtKAQ4CP63nbUiEJC7rpF+0bz/GxShL0JkD+REntc5PtHHkDAogkg812yJry
 bYhuFAOybrYiCyKUlw8zUaqUBIHYR9s22sbiA41OSd9Urj6jTslWIZim0S0SJ84KH2gYhDuUCv9
 l2+kP2gH46VAJ8exKPcgDi8t6ZTVLCfPraENw66q/eipTTl4C+OdOeOZbbeLyOnewW1bG9aK57V
 UiEfxEYIuP1oL3OBewNQWqeIOO7Xk0CJ6H/Rz7B0TZqwglOXKqP5vrDw94NQ56XECh40++BYt2B
 lvFEOVmazz9IYX6Kk7gG3SQosryJscbpJ4zJPT18P+2Fk80bV6CyU8F90oqlz9xl8eukh2QtyNF
 K8GQKpRIg3FdShe1KgReDpelgE19GhbwMA8H825GLLZh6QEEdNCuQ5EwXzNiXbR5M/drdDZn58b
 e6rcgCNjPD2oYCtj6WLrmCCl23T4p6T9E7l1gJNZEM=
X-Received: by 2002:a05:622a:a192:b0:50d:efc1:841d with SMTP id
 d75a77b69052e-50defc18f77mr209163071cf.23.1776281953156; 
 Wed, 15 Apr 2026 12:39:13 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:e5:500:8e39:827f:e928:9eb7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6cbbc1bdsm18245406d6.38.2026.04.15.12.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 12:39:12 -0700 (PDT)
Message-ID: <69dfe960.050a0220.1c3509.e29e@mx.google.com>
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
Date: Wed, 15 Apr 2026 19:39:11 +0000
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

SGkgVmlsbGUsCgo+IEl0J3MgaW4gdGhlIExGUCBwb3dlciBibG9jayAoNDQpLgoKWW91J3JlIHJp
Z2h0IC0tIEkgY2hlY2tlZCBhbmQgaW50ZWxfdmJ0X2RlY29kZSBzaG93czoKCiAgQkRCIGJsb2Nr
IDQ0IC0gTEZQIHBvd2VyIGNvbnNlcnZhdGlvbiBmZWF0dXJlcyBibG9jazoKICAgIFZhcmlhYmxl
IFJlZnJlc2ggUmF0ZSAoVlJSKTogeWVzCgpBbmQgbG9va2luZyBhdCB0aGUgY29kZSwgcGFuZWwt
PnZidC52cnIgZGVmYXVsdHMgdG8gdHJ1ZSBhdCBsaW5lCjEzNzAgb2YgaW50ZWxfYmlvcy5jIGFu
eXdheS4gU28gdGhlIFZCVCBnYXRlIHdhcyBuZXZlciB0aGUgcHJvYmxlbS4KClRoZSBhY3R1YWwg
aXNzdWUgaXMgdGhlIGZpbmFsIGNoZWNrIGluIGludGVsX3Zycl9pc19jYXBhYmxlKCk6CgogIHJl
dHVybiBpbmZvLT5tb25pdG9yX3JhbmdlLm1heF92ZnJlcSAtIG1pbl92ZnJlcSA+IDEwOwoKbW9u
aXRvcl9yYW5nZSBpcyAwLzAgYmVjYXVzZSB0aGlzIHBhbmVsJ3MgRURJRCBoYXMgbm8gYmFzZSBi
bG9jawpSYW5nZSBMaW1pdHMgZGVzY3JpcHRvciAodGFnIDB4RkQpLiBUaGUgVlJSIHJhbmdlIGlz
IG9ubHkgaW4gdGhlCkRpc3BsYXlJRCB2Mi4wIEFkYXB0aXZlIFN5bmMgYmxvY2sgKHRhZyAweDJC
KSwgd2hpY2ggZHJtX2VkaWQuYwpkb2Vzbid0IHBhcnNlIGludG8gbW9uaXRvcl9yYW5nZS4KClNv
IHBhdGNoIDIvMiAodGhlIFZCVCByZWxheGF0aW9uKSBpcyB1bm5lY2Vzc2FyeSBhbmQgSSdsbCBk
cm9wIGl0LgpPbmx5IHBhdGNoIDEvMiAocGFyc2luZyBEaXNwbGF5SUQgdGFnIDB4MkIgaW50byBt
b25pdG9yX3JhbmdlKSBpcwpuZWVkZWQuIEknbGwgc2VuZCBhIHYyIHdpdGgganVzdCB0aGF0IHBh
dGNoLgoKU29ycnkgZm9yIHRoZSBub2lzZSBvbiB0aGUgVkJUIGZyb250IC0tIHNob3VsZCBoYXZl
IHRyYWNlZCB0aGUKYWN0dWFsIGZhaWx1cmUgcGF0aCBtb3JlIGNhcmVmdWxseSBiZWZvcmUgYXNz
dW1pbmcuCgpUaGFua3MsCkpha2UK
