Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AB9CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F45211270E;
	Fri, 16 Oct 2026 09:49:43 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD9C11270E
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:49:37 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48dfaaea30cso642758f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792144176; x=1792748976;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ixy6hNcTUuWFgZUOYyQDAsnRCW5sJejSxzxn5qXltrA=;
 b=dO1h3IKHRYDJZhd5PTkJPxiSv/J9t8kw/XGMxbP8347AbTe1KTveh6UMYAIr2d5B+m
 qKJCGZblWhqjuQEKmYxJolDUIYI10ZTdtQ3iRPHioIOOqxR18HYSFtPWLlrA0SxRd3I+
 s/uEmRJx5CwQAJmcTFCs8ranMhGtZZ7emIc71tcUcOCoXtDPkO+PwisW4tJvJ8SiK4GF
 XLeeBntV97a2b406CcrbuFyx7Zv+lzd9ithVcdnwEkwm3HELRhwwmFPKlg2xdXNpj6Tn
 hYQkHu7/biZOqkQk0dQuji6taeVJFNkkd2FqMzSHttQItLsC4n7w7JCCoUtvH+yq/jgK
 sVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792144176; x=1792748976;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ixy6hNcTUuWFgZUOYyQDAsnRCW5sJejSxzxn5qXltrA=;
 b=cD5MWhmnoe6y9RhtiRPEqf/C/P5ihYXT8g3I3M64Zj1TIpuCHIvsZZNwqbryIBZjrm
 mGlK+OQ4WfL2rWyIOJS/OKpcgj4LGpZpWuEN5pgu6nRIcOb/OG2xTyYVoNn2Wkxb4dP/
 03y2fJN609j17wceRkYQf+Uqhj4iz68NmVWVhc6930ns9l9AEOJHTbqXunD51GPU1eVq
 wyT/f2L30m/uGMTrJoUu3o56sTFvjem4wgJ64YWFHuA0VT8B4YfDaTy1gT8dmKdC7WmA
 2VqrknkhkHXMgKcDc9actafa95rCmDTdW6x5UkvAwh8g943astMuEC7uBSaT5HkFikFW
 cL4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxua4Oe+CfnqXUieve/VmJss7jtKZ92jmMy8RdKN1VToy7UdG7VK26CfLcdJ+eDQdMpMb7O25k0DjA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKBIece4XnJordT+3A3juHWZbT6JUl54AqUfTmp+TM+sM0o+DhB
 mVHQkKFe5ShOox3vP5MObCamPwtEuyZ7ILQgTbIA6ItE7KhVLfQWfANgFxpS2e8wgWUNIQKk5FN
 OOZRdbrZGGIx+Rqh0kA==
X-Received: from wrhm28.prod.google.com ([2002:a05:6000:181c:b0:48b:1194:3d3d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:46da:b0:48b:68:594a with SMTP id
 ffacd0b85a97d-48dbaadc11amr31197776f8f.12.1792144175630; 
 Fri, 16 Oct 2026 02:49:35 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:49:34 +0000
In-Reply-To: <20261016085724.1031766-5-phasta@kernel.org>
Mime-Version: 1.0
References: <20261016085724.1031766-2-phasta@kernel.org>
 <20261016085724.1031766-5-phasta@kernel.org>
Message-ID: <atHzLshg2bMc2-78@google.com>
Subject: Re: [RFC PATCH v6 3/5] rust: DmaFence: Don't drop on signal
From: Alice Ryhl <aliceryhl@google.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boris Brezillon <boris.brezillon@collabora.com>, John.harrison@igalia.com, 
 da.gomez@kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Fri, Oct 16, 2026 at 10:57:22AM +0200, Philipp Stanner wrote:
> The original design for DmaFence intended to comply as strictly as
> possible with the "dma_fence contract", which, according to some, says
> that a fence must only be signaled once. Thus, the implementation was
> made so that a DriverFence drops on signal.
> 
> While extending JobQueue's capabilities, it was discovered that this
> characteristic causes - unnecessary - trouble: fence-data must be
> dropped in an RCU-deferred manner because the C backend demands that.
> However, fences are often signaled in atomic context (e.g., interrupt
> handler) where you don't want to drop, but signal as quickly as
> possible.
> 
> Actually, there is no real hard reason to enforce that a fence can only
> get signaled once, because the C backend is robust against multiple
> signal attempts.
> 
> What is decisive is that a) all fences signal and b) they only drop no
> earlier than 1 RCU grace period after signaling.
> 
> Don't drop a DriverFence on signal().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

This seems reasonable to me, though sashiko makes a good point about
being more careful when updating the fence counter.

Alice
