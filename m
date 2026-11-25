Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634D606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=mFodScwZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=R+UPbx9w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C76410FBB0;
	Wed, 25 Nov 2026 11:39:02 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B787D10FBB9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:38:50 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id D5C48EC0C80
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:38:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 06:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1795606729; x=1795693129; bh=iAD+Ad7NT5
 /4uS4i5Ra5VqZcMWRddUP0s1yBjvo3Qp0=; b=mFodScwZNfmtYTSwLaQ6w1ZaE1
 g/nJpbXdJq6ibWzfLs4pqaeFubKwyUM8rvlVE+8HunCNxISFis7OySN/XWvjd/X8
 he242huEmUDqZlF06zv9F63dcEmVk5TVvksQmzRBmrLP5LL4daEu9SmW7VMbGnPo
 ULQa4XZhIifW0TzOY+5p88v+wvNXK85YrZc29S7Zc2Aqku78b94A8UZRuYA1eehb
 k2Bufl0TreNi/R4+DZh+5wCJWcrv35I9Om3qCBNqpegr92rg75qJRpR/ZU8T32Ff
 EGtEviMjXASYGiZG6D6CToBcIewt20Tt2lL/7j6KNBXGbXzUTDrivODoTkuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795606729; x=1795693129; bh=iAD+Ad7NT5/4uS4i5Ra5VqZcMWRddUP0s1y
 Bjvo3Qp0=; b=R+UPbx9wJa0kfhpYxIZryz0kFZ/vtcHeB16R6Om1V3N575RePKP
 2y+TUBXI8VBwnIQ1s0A45nA78cYKmLKXjROrfTvNiY42PX07zhub1GEScys65+Y7
 KfBh5Ei+5jHa8GEPVW/E2SQQhwG3nwLmcCU1EzU45NksBJ+IBcFt6odp7XRXKCk5
 eAlyPUT1edV3StPgClcC2csQbNzz3H7LhWCTKJRFYEG2bgRd6LAHLqaXtLxGV1so
 hpdq5q60q/gM4uN3IX5B1Zxq5oi+6BFhdqJwOv+vAlW8vhqCHDAcSRLRIT9kZCaL
 jZwgiGA/mbUJqpAnKMWDtFA81AjCJUvoewA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795606729; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:4Y1d9kWVfwuptl5qOx/ADRBdJuogJZVYqqA7pLdqzrsY99N
 338dwr2BGZy9HvyVH1fjVgbS6FDLRgWuXBPCSI5GsOVPgeW9LQKTPFbH8QZIzLb4
 uUB40yk+XLYiVoS6EmoKJMP4rnUGqiq3Y2Y+me3LG1y/74FS7na38S0P1CjciLJI
 3l/HsQAgoXB9XsJV+3SYG9di9xMA0bXeNV/UDijbzX/xnhYzgWgjWBnTlXi1eHIk
 edkF0bAZEgAamcRA6Uj6+zAUMjUX7uXYAmbSOJTN3kNKRPa+QdVs4tgsPHZm3ilv
 PvD7r4Z1q7indI/lJtlgpFEnNTG0o6D8gtKN/xA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:TQcZS0GE3XFOemI5U0d/fmAcYiMbdJkw43VVp64SP9w=:kvKhtlvYmOwozjxXOiNVGWZFpFm94DrmU31h+MpA/88=;
X-ME-Sender: <xms:ycgGa9SFdQl1jQ4jMEo4K33bty-fwVkyXMjAE3nbb9j2F0d_WvUUkg>
 <xme:ycgGay0ktdFn8uwp0901WY5xHlbzReDsMBl5HOw7JxKAWoFhLs92EAZEhKB0QrpRx
 1ppgIf6Eq5YBsalwq5oaNko8PiKJzRqql-OLYmer66gZLiN4YRTf9w>
X-ME-Received: <xmr:ycgGa-LKi8H0ZQ2xNZAMaeOYLl9DjlPkn2MeV5mIYQSlJ6fU28KC6xD1Zrx_KqvQBstRKioop_sSxKHtDcTW4FR-cnl66AQ7q2g>
X-ME-Proxy-Cause: dmFkZTEbReCOWvmoFnuw+QSaZ5Gsjwx+kckQkxqBv+HHd3snXsECRlQfnwZpk90zFsExLW
 aOe3walW+e+AJA8K89u3mwa0DtoP1NOon/UrnuIhMgCYGen63cQbsifY1HoQNgozbgZnRC
 I6hZylZlOl4/iMBbJuJXOTvWar4dYI99WblysqeihImVHE5J6H2NOxEDcqP7+68EFSYF3t
 2flf5Fq5QfNHfbYFMyqM+0e+0/b4px0j1He6PUzHNZZqu/s/+0wFg/4UpRUzGdPguePBR5
 lRUTUUOcJrAZtXQwndfoaYb2LbS7L7cdx85al77wXWPjxIWByF4PiMtngYUKn8WKWpCYko
 ApBBPKIp2rv/WjBxikjN05YpYBPbuY8m1qB/fWo5VzXUDJeQvgwzhMMgwQT+mjLaY6dcTX
 24ZKrzekUUwa+RPclb0OR1tFi3Yyl660g+pnx2KIxSTcx2UdZXia3XYOnycTQNvqSv9xFx
 6PXafimTY3wjkX2tEUAYW4VJVb3/6p6JNTjdp+Mly1KAegrgGfr8YBI7ttAQrNX7iV7mLE
 1HQafjFoMn3nF4+gppa+DVvAYw7hvN79cbCgAIxgfiCgGwrQSDNy4AaycHPTbl+xEHshl9
 sPFlJI2qOyiHc47Er4QnDzVpL4yR8b0/Pa/egV5EZzPwcDfWRihp/avTjF0g
X-ME-Proxy: <xmx:ycgGaz_LkAnW346zBRkPrkmzmrYtIXAmhy6l3F15NR_DCuwylDEBLA>
 <xmx:ycgGa_miN0qCr2OHOlx4b31gKmwpn4ha83CoPlUgMskzThYdZgsBuA>
 <xmx:ycgGa-UggBgCpdncAGhg2qtsEu2521-M2h3H83DiPQCHnrAJRqkBTg>
 <xmx:ycgGa7p26FxlB1JS4YBKmGoCfufx2HTDbTUcp6JUS2-C9quo62GWlQ>
 <xmx:ycgGa4fgz3mLSTN1-f7K6stb1uiD-XaR0N5X5piWrEojxsM2gxPpIkOF>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 06:38:48 -0500 (EST)
Date: Wed, 25 Nov 2026 12:38:46 +0100
From: Janne Grunau <j@jannau.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sami Tolvanen <samitolvanen@google.com>, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 stable+noautosel@kernel.org
Subject: Re: [PATCH v2 3/5] rust: drm: gem: shmem: Implement
 prime_import_sg_table callback
Message-ID: <20261125113846.GB372978@robin.jannau.net>
References: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
 <20261124-rust-drm-gem-shmem-imported-sgt-v2-3-000f7a9ccb8d@jannau.net>
 <awXA70GWssuU991c@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awXA70GWssuU991c@google.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 04:53:03PM +0000, Alice Ryhl wrote:
> On Tue, Nov 24, 2026 at 12:37:45PM +0100, Janne Grunau wrote:
> > +        // SAFETY: The DRM shmem helper only invokes this callback for a registered DRM device of
> > +        // type `T::Driver`, which is `Self`'s driver per the `AllocImpl` impl below.
> > +        let dev: &Device<T::Driver> = unsafe { Device::from_raw(raw_dev) };
> 
> `drm::Driver` in `rust/kernel/drm/driver.rs` currently declares:
> 
>     type Object: AllocImpl;
> 
> without any constraint that `T::Object::Driver = T`. I think we should
> introduce one similar to how Driver::File constrains this?

so changing it to `type Object: AllocImpl<Driver = Self>;`?

I think it's hard to get that accidentally wrong but since the change
relies on that constraint and we can express it sure.

I added it locally for v3 but feel free to make that change before
pushing this series to drm-rust-next if there is nothing else that
warrants a v3.

Janne
