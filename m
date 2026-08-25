Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A5CC61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7492910EA24;
	Tue, 25 Aug 2026 12:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ePBRtgN2";
	dkim-atps=neutral
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A48910EA10
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:10:10 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49571407d1dso25762015e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 05:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787659808; x=1788264608;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rq043gvhHpHDZLtYzyheTlOt41eSYp4wtv15MTCDIrc=;
 b=ePBRtgN2Z6MyIFQYpNy0MoNlO1TwxJ97AWl2YuFL86QXUZQo9xdJoWZs8LgRFsh60Q
 XlQR93430jTz9oIlQtP+V3YBBawSqsSUQIMM4TWVYN53NICqftIHtEgyYsZqplNSuk9r
 UoXRVD5TrgB38cFTaT3CykFpqMxePFJv2C6Un1fNszZodgSC6FHR6HhJ0235NvT02Tw9
 UTt2H2ickymIQ2o6/FjZMnqrBmdxi/Jtpicj3868m4Kq5dYvYLJCWuzbC3wiNs05cFUj
 bm9ejyZN+cuWaOToh/Dk4lrlYrasbIZqdBhAhIaf3482Y4XbIp44Syhnn6pt8bl+aRoK
 kAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787659808; x=1788264608;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rq043gvhHpHDZLtYzyheTlOt41eSYp4wtv15MTCDIrc=;
 b=r/40RO4DeVV2jcPDreLFI6iv3jJCwCLsaJSu/k1w/Zxf6DpPueSGyW5n7/GLS9LthO
 bmuDorkoBD8sd7sCRnMMw7d6nL587ii9fqRW/imRZIWZ8AApokPVGmJegcEyal2D25tR
 vRs4XjDLBr3HJiwBYlWgzsasX3fZ7Kwow0DF3SPSsIIN1RtQtY7UAau3SNTSL42M2Dhu
 zBCwS2pZUiMoAqbH5R9zg2jNUPTdsD5REOQrJO6tiTncowisbpthB7gDQDLtBjoZw0ym
 YDzgKy67clANPGe2k0U4MjTunzzc+uoRmoDYTd46PVDXTGEq6+oJwYfEKDVUNtNuDoRB
 z45Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RooE0mDoq1gESclwxejCPRoFcLUSaY9Gvr+Ps5kHgWj6eYDwNmePxqbElwHXW/q7pfL+p8dWK7popc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lhQmEud3VM1Gs/+JRi86ysMy7ncv4MRvYONCRz8DWkAZnA7cNd
 tqNKi39NLApFo4Niq323IjkFMpK+9j/D6kY+YnChdLlWwS8k5i4d8Gn2IurCtpk/sg3jr3VC//3
 kYSZ7U4n5vTmKdUZCdg==
X-Received: from wmbjz11.prod.google.com
 ([2002:a05:600c:580b:b0:499:af1a:8d42])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3544:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-499b8301874mr380176875e9.7.1787659808082; 
 Tue, 25 Aug 2026 05:10:08 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:10:06 +0000
In-Reply-To: <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
Mime-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
Message-ID: <ao2GHqop_Z_9bsyl@google.com>
Subject: Re: [PATCH v7 06/10] rust: id_pool: take a NonZero capacity in
 with_capacity
From: Alice Ryhl <aliceryhl@google.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Mon, Aug 17, 2026 at 04:04:20PM +0900, Eliot Courtney wrote:
> There is no good reason to allocate an IdPool with zero capacity.
> Reflect this in IdPool::with_capacity.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Why do this? Zero capacity is not an invalid state, so please don't
impose the nz! macro upon users for no reason.

Alice
