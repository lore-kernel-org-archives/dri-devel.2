Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD6AC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC47310E09C;
	Wed, 23 Sep 2026 07:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="V4zTCkTj";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C122D10E09C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:42:38 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dcb8so495317f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 00:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790149357; cv=none;
 d=google.com; s=arc-20260327;
 b=ESI5rdq0jJ/bHVsd1aUTuqKBvuEeq7A0AqHrI9XYwgHL7wZAQEDd951zRFskxlgMiz
 qgxIoVhTePQpssoPMxG0RRKXivEjj1urrroSRVmL+DdoxYR6+uPVNeoSF+A9g0LToCK3
 z2In0+qrRx9QlTnECBz3uICu0XgKO3HNTsOmjexhXcUCbT8hkv7XcsPO3ghDVwAmRsIW
 d8T2/YqnTwST60ITU4yJZGo72zsVg79EAIhUsVaT6Cz3Fd89MuFZJ0+Sv2cHGUJsPjzI
 UrQqXipEuO041hExxjUHrugZO27f7FZac57cliycQHSJ+6WtgXRr4W84IemWP76reVCu
 M9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/IJk6BwyL2t+xmXjHGLGD+TklywKkZlMfXsjfutBVv8=;
 fh=RAVGsXFQMF81X1jR/2mMSPoP20O8rs61JWMQCoD0Mqg=;
 b=G5ik2sRPHCw9nNUQSk2wrOFo/MiMXu3Kk4eMrjJxJKorCYLeuRWRIkAtxqkJeE55F1
 eyiZuG6QJNZD3K2RMuXmaOxKhYsUvP8Q0Qh5TcACW1nS2kgp/jPXPgDmZ3aFzm9KfUh7
 PwuOPD1vcd+IfomE88Khh2BkHJE0ykrC3uirSgU9PHKLMCGUjnOmHK+cllIhL266CnwN
 fNR5fWGK0pEPCMwcf9NftjhIKMFB1iDfJJ+3g6dy4cxVldNq2sGG/R/Le6UngZE3kENo
 bjzhmQmTK+BrGVpFI3IZ5kVk1Vv+aylUqTb9/PCdEromhahoPcfFcK/PtLBox0urYHVv
 PIDg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790149357; x=1790754157;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/IJk6BwyL2t+xmXjHGLGD+TklywKkZlMfXsjfutBVv8=;
 b=V4zTCkTji8NVmCmeWrbBvDZgs6Ykc8M6ww4QEMdKqTRHnVMHcII6lv+iBGoUJxgilz
 cZAYfcel4zpcZzutNIz/bKakjwACPD8h9xDNAojoqcvt8txxlKY6bWyMJbVZLwKMM0Ce
 nY/8CeZpNqn2Mcx8YaSrUpR3q8j+ec7F2Uj20u3t8GKCc0hMMGcpjUHpJ6rM5/hdP26k
 fm5lIPASyoZ5w47xmKq6/zKIAJrePZPuVDaHj0vwcDsYjJzQNr6swJwpG0QHi07dsQUw
 U9ehLSORwZtrrLeGbBpXsBlvlqhRzFI+2nHrd2cMp2ixPqPc7OyHUbmid5vxa/v145er
 1S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790149357; x=1790754157;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/IJk6BwyL2t+xmXjHGLGD+TklywKkZlMfXsjfutBVv8=;
 b=eqUQsJshSUcvu4B3WHKRdtpR3+B1DGxVNX5BnP/r+V7pQ9GLjC0uJ6n1vSyzkxm9Qi
 14OrTaYn+3Xh6m2PS0ew3XUqJOJJPlQ4dUTmlsgRAb0sdeaigFAC/FYQ/9ZNDZItQYrG
 Crs2tN5llTo+Ee7XdgX+BV2HdhyRmbAcd4cPbxPih0OowrVqIPaVHklm8mx+oz0+/kOi
 rPzjrBgyBUGYc18ufAc8QcJG/LKamqoozj0r+X2IsH8ak80H04jKZWKiKm3OelKK96UY
 usBUsToIDOnBo8r4v0Y51a4hBu45jXUbT8nfmWjHYWw3RFgAJxOmvk8XpW4jQlaX5jIO
 Jdlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaNFuwHDn6yG3dzFTsJr63qYCGLgbltHynehkT6vJPsJOfcQ2FbLXl+AZ+KI9fU78HszcJsqOJ1qg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mHXj7dT2D2UTfY63tmbYZSRhqsCSaE2xRwmxHsf9g6DwHUaQbJ
 Cr5sFh1M433O9CILHiiXlzWbI0KsjwCOK+XfQg9VXeZq/8S1AA/yzZsj2lZhkCn+cGniDgW/6Cc
 VjcNZby2wnNs7etmMCJLxOrO98JR+vRRcylD5rsQw
X-Gm-Gg: AYBFou26ag+MGt52SQ0pJ0/lJge5UtGOysBJwHSEe7pyligHTg+PqOF19LZo+RE99iV
 48VVNbuRERo9GdrNpp7t+qJH00n7LlxRPraEyFwz+b9EF+M9vS1y1VJU/HelOjl2K/wGD/CGpWx
 RUX//Xx8TEqfcwWezv3QhFUykHZmqaRbMSujCMIXIUxVyU7+mTJxXfjK2buK/m+nQjUCZh5kcVd
 UV7G9ROvIcz175OH640U+e5xZEnhUCNuuwwldmuAPPcqGtpuJqciKPY/FWobu8UHIjiuILimQ+v
 Yl1B0+h98zPN2fhnBKxqbKrNT4awuUJ40prpY8OG2/yP3jZT92VpQQePRKpakJWJDBvrURM2Djh
 8mOKOYncSbt3LkqaLXFOcSLOLMDjhW3s=
X-Received: by 2002:a05:6000:178b:b0:486:f1ec:f939 with SMTP id
 ffacd0b85a97d-488670a6c46mr3157053f8f.40.1790149356616; Wed, 23 Sep 2026
 00:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260922-b4-gpu_info_zero-v1-1-7259840069c6@collabora.com>
In-Reply-To: <20260922-b4-gpu_info_zero-v1-1-7259840069c6@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Sep 2026 09:42:23 +0200
X-Gm-Features: AclHuK_kOTENlrajsbD3PM-8sSHORN3Gp4PV1SmVXbX3HMVeZKOfsOHmtEYRT3c
Message-ID: <CAH5fLghN0w908Z-MYDfmaeC7gvAB78MMT7zg599=1kU0HexkOw@mail.gmail.com>
Subject: Re: [PATCH] drm/tyr: gpu_info: zero out new/unused fields
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 karunika.choo@arm.com, boris.brezillon@collabora.com, laura.nao@collabora.com, 
 steven.price@arm.com, liviu.dudau@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Sep 23, 2026 at 1:16=E2=80=AFAM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> If a new field is added to the struct drm_panthor_gpu_info in the panthor
> uapi, Tyr must initialize this field or it will cause a compile error.
>
> To pre-emptively avoid compile errors, use ..pin_init::zeroed() to zero
> out all new fields added to this struct. Tyr can subsequently change the
> initialization as necessary. Also use it instead of manually zeroing out
> existing fields at the end of the struct.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Merged into drm-rust-next, thanks!

With regards to sashiko bot, we should look into whether the
MaybeZeroable that bindgen adds to structs applies on this struct. If
so, we can remove our unsafe impl block. But it's not an issue in this
patch.

Alice
