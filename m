Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37D1F531EA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 05:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160E010E178;
	Tue, 14 Apr 2026 05:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBGbZlDV";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E4110E065
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 05:44:48 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-8ac9ef74131so34136086d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776145486; x=1776750286; darn=lists.freedesktop.org;
 h=message-id:date:subject:cc:to:from:content-transfer-encoding
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aDm5Kil0HXsnjHv6GNGtwXDhX9a19psMf0K9NXnVpWM=;
 b=RBGbZlDV8gakQRnSi4JGyamPVuioZzIN1Q6lhlsRUs2shYvR4JuJUX0yK9RwTtfE2p
 DImU+JO+wAOXllEvgFnwvDXYemc3u+y7XYn3Yhvq89BGOGAuBYWXfHnwD3alHgF8QdPw
 yvSzvpjKgAaf9EvL3dVt1IoNNaaompaO6cry3a9Zp9FjysSc5A76o7S74HYp2okMuTJ8
 w2g0iNy9pVV3cWrL+YW5UqGJlAwzMnhrmB0hsYftaGowDu4psEvkdQofFwzSO5Tn7Pru
 F+kmN4yMJOH/YAx7n2XQEB6LkPJnQmczm0R9UrXlfvN+lBwjRRrfPm+qL1PQUFq5fYgN
 bXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776145486; x=1776750286;
 h=message-id:date:subject:cc:to:from:content-transfer-encoding
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDm5Kil0HXsnjHv6GNGtwXDhX9a19psMf0K9NXnVpWM=;
 b=LhLvMU1YPyGpopJlVrsU5yPfYF1jIKbWiDDKvp5JD3NPLl5LscUQLykcJAIWjR2oTi
 J8cfXBq7vJtuhT7FjVOInas6RcOqtcLv5gA53i9ynYIRhRBjSWQx+MFCEyiqGLlZcafU
 yvKgFTup3h6aDW229AnbpvNQwYdKpcKXDluHVSaYwztJmkXOSq/ZX9S/fS1g4JuW3vy3
 VY7Tqt7gFLVZWKV9BtigyXdw9NvZBwWinVZDbNVfw5F1GzLDcDXZYTosMVP0Y5IBk/bV
 lMG+GlOfuhMwSHP50Uxtz1NRu/jBNGakcS6mDwLajWljgUSeZclAnlggB2mSKHrMFavc
 TltA==
X-Gm-Message-State: AOJu0YxAOe4/D6R0JvjPR74dOBUWZ7X3TS/9G/fe4E3IzZjcoRuQqPSv
 nPJJVl4+v1LM7HgboZYqXtXvEbxa2bXsQ2r7XJ9wFR1SY/hpEk0q8TGaKg/A05WbHD/b6w==
X-Gm-Gg: AeBDiessHl0CAEKYmy45C7ZVXaFXEWKqmhj2uXpsHHqE6O5fAEk0R8owkYvL3eon0ng
 Z2emT0xuYkY+W5tAvka3O9eqTe1IVFJMufNYQ/2dyLaP37VinCEUtiGi3kZqqygebDCS60HYK7U
 ouSW7iClvCQ8QiL9DpNCLGE8RyA/5QlnRKYzmlE6pTBoHg98Vst4BbCsAtu7n0JY8KjE4483tiu
 y62y/ZVMkJbD/P8iJHv/IiXPhIPnt0QtiNkk+hlwKUFzlayK9bbIblECudLoo1p9P3FMen2uw41
 l5j3UcgcsV5QBlepU2imSpVCy2F5Y+tB+QqI524/2rVdGtCAu1sRsn1XiX6j1mUJpd2jCxF45zF
 JIsNbE3WfJwsAqOvkZyCiXK5qafOAWMTqdfFQuHA8RkgGH+1/tbURwtiiunEZPkR7wJeDaMmlzz
 57z2L85DAeafb03AXmfg2/CoJgoa7Kfxaly2Zv6P4JPhS/GnvwpS3U8vewSJERyrwbEoStkwiiR
 RQ41hzs+Q==
X-Received: by 2002:ad4:574d:0:b0:89c:df61:7a06 with SMTP id
 6a1803df08f44-8ac862f56c6mr262396686d6.48.1776145486489; 
 Mon, 13 Apr 2026 22:44:46 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8acb925d457sm22924196d6.45.2026.04.13.22.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 22:44:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: mcanal@igalia.com, itoral@igalia.com, stable@vger.kernel.org
Subject: [PATCH v3] drm/v3d: Reject empty multisync extension to prevent
 infinite loop
Date: Tue, 14 Apr 2026 05:44:45 -0000
Message-ID: <177614548527.3603641.5360701002746181082@gmail.com>
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

djNkX2dldF9leHRlbnNpb25zKCkgd2Fsa3MgYSB1c2Vyc3BhY2UtcHJvdmlkZWQgc2luZ2x5LWxp
bmtlZCBsaXN0IG9mCmlvY3RsIGV4dGVuc2lvbnMgd2l0aG91dCBhbnkgYm91bmQgb24gdGhlIGNo
YWluIGxlbmd0aC4gQSBsb2NhbCB1c2VyCmNhbiBjcmFmdCBhIHNlbGYtcmVmZXJlbnRpYWwgZXh0
ZW5zaW9uIChleHQtPm5leHQgPT0gJmV4dCkgd2l0aCB6ZXJvCmluX3N5bmNfY291bnQgYW5kIG91
dF9zeW5jX2NvdW50LCB3aGljaCBieXBhc3NlcyB0aGUgZXhpc3RpbmcgZHVwbGljYXRlLQpleHRl
bnNpb24gZ3VhcmQ6CgogICAgaWYgKHNlLT5pbl9zeW5jX2NvdW50IHx8IHNlLT5vdXRfc3luY19j
b3VudCkKICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7CgpUaGUgZ3VhcmQgbmV2ZXIgZmlyZXMg
YmVjYXVzZSB2M2RfZ2V0X211bHRpc3luY19wb3N0X2RlcHMoKSByZXR1cm5zCmltbWVkaWF0ZWx5
IHdoZW4gY291bnQgaXMgemVybywgbGVhdmluZyBib3RoIGZpZWxkcyBhdCB6ZXJvIG9uIGV2ZXJ5
Cml0ZXJhdGlvbi4gVGhlIHJlc3VsdCBpcyBhbiBpbmZpbml0ZSBsb29wIGluIGtlcm5lbCBjb250
ZXh0LCBibG9ja2luZwp0aGUgY2FsbGluZyB0aHJlYWQgYW5kIHBlZ2dpbmcgYSBDUFUgY29yZSBp
bmRlZmluaXRlbHkuCgpGaXggdGhpcyBieSByZWplY3RpbmcgYSBtdWx0aXN5bmMgZXh0ZW5zaW9u
IHdoZXJlIGJvdGggaW5fc3luY19jb3VudAphbmQgb3V0X3N5bmNfY291bnQgYXJlIHplcm8gaW4g
djNkX2dldF9tdWx0aXN5bmNfc3VibWl0X2RlcHMoKS4gQW4KZW1wdHkgbXVsdGlzeW5jIGNhcnJp
ZXMgbm8gc3luY2hyb25pemF0aW9uIGluZm9ybWF0aW9uIGFuZCBzZXJ2ZXMgbm8KdXNlZnVsIHB1
cnBvc2UsIHNvIHJldHVybmluZyAtRUlOVkFMIGZvciBzdWNoIGFuIGV4dGVuc2lvbiBpcyB0aGUK
Y29ycmVjdCBkZWZlbnNlIGFnYWluc3QgdGhpcyBhdHRhY2sgdmVjdG9yLgoKRml4ZXM6IDkwMzJk
NWY2MzNlZCAoImRybS92M2Q6IERldGFjaCBqb2Igc3VibWlzc2lvbnMgSU9DVExzIHRvIGEgbmV3
IHNwZWNpZmljIGZpbGUiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5
OiBBc2h1dG9zaCBEZXNhaSA8YXNodXRvc2hkZXNhaTk5M0BnbWFpbC5jb20+Ci0tLQpWMiAtPiBW
MzogZHJvcCBkZXB0aCBjb3VudGVyOyBpbnN0ZWFkIHJlamVjdCBlbXB0eSBtdWx0aXN5bmMKICAg
ICAgICAgIChpbl9zeW5jX2NvdW50ID09IDAgJiYgb3V0X3N5bmNfY291bnQgPT0gMCkgaW4KICAg
ICAgICAgIHYzZF9nZXRfbXVsdGlzeW5jX3N1Ym1pdF9kZXBzKCkKVjEgLT4gVjI6IGNoYW5nZSBj
YXAgZnJvbSAxNiB0byBWM0RfTUFYX0VYVEVOU0lPTlMgKDcpLCBhZGQgI2RlZmluZQoKdjI6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2RyaS1kZXZlbC8yMDI2MDQxMzA1NTIzMC4zMzQ5MTE0LTEt
YXNodXRvc2hkZXNhaTk5M0BnbWFpbC5jb20vCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9k
cmktZGV2ZWwvMjAyNjA0MTAwMTM5MDcuMjQwNDE3NS0xLWFzaHV0b3NoZGVzYWk5OTNAZ21haWwu
Y29tLwoKIGRyaXZlcnMvZ3B1L2RybS92M2QvdjNkX3N1Ym1pdC5jIHwgNSArKysrKwogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92
M2QvdjNkX3N1Ym1pdC5jIGIvZHJpdmVycy9ncHUvZHJtL3YzZC92M2Rfc3VibWl0LmMKaW5kZXgg
MThmMmJmMWZlODlmLi5mYzc0MzUxZWZhZDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS92
M2QvdjNkX3N1Ym1pdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS92M2QvdjNkX3N1Ym1pdC5jCkBA
IC0zOTMsNiArMzkzLDExIEBAIHYzZF9nZXRfbXVsdGlzeW5jX3N1Ym1pdF9kZXBzKHN0cnVjdCBk
cm1fZmlsZSAqZmlsZV9wcml2LAogaWYgKG11bHRpc3luYy5wYWQpCiAgLUVJTlZBTDsKIAoraWYg
KCFtdWx0aXN5bmMuaW5fc3luY19jb3VudCAmJiAhbXVsdGlzeW5jLm91dF9zeW5jX2NvdW50KSB7
Citkcm1fZGJnKCZ2M2QtPmRybSwgIkVtcHR5IG11bHRpc3luYyBleHRlbnNpb24KIik7CityZXR1
cm4gLUVJTlZBTDsKK30KKwogcmV0ID0gdjNkX2dldF9tdWx0aXN5bmNfcG9zdF9kZXBzKGZpbGVf
cHJpdiwgc2UsIG11bHRpc3luYy5vdXRfc3luY19jb3VudCwKIG11bHRpc3luYy5vdXRfc3luY3Mp
OwogaWYgKHJldCkKLS0gCjIuMzQuMQ==
