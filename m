Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F74606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fNNmtoUn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED16210EC5F;
	Wed, 18 Nov 2026 16:57:33 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44B510EC5F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:57:27 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso938677f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795021046; x=1795625846; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q4KDOTPdWsAvn5fnJD2QpV13fNXrFnBH5XSZbqxlxTc=;
 b=fNNmtoUns5CCDDeWCcOCxcj3FP7HK0H/K8HlM8uO9uFiPlygsNKAR4DhlaRHIEjb+d
 mt7417qSO5mmU2n+eDMglzvzaxtUfnDZVBa6EZOIkCOo0th03W7zjKWMtGpKrwQ5QKq2
 1VKfAhaL0APAebVAD83/qNn9ljUB0JFKCw2Y5UzRs5HamVkvZAahRHR9b6bSwhxezdEg
 fL6EgS1YuTojQAXBNr0VLwvWRtDQ3hiaYnKViW9QgDY1x63W6QXgn8mDOuXGMtunmZKl
 DqdEs4BGEBtDbc7CqzMsaHP5miveG/+EUhH+OGaE86ITjCU7T6ZFjPjVmscMGSe5CM7M
 /6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021046; x=1795625846;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q4KDOTPdWsAvn5fnJD2QpV13fNXrFnBH5XSZbqxlxTc=;
 b=FJpB4bvFGR06jM54Zb1O8QaEYw7jnsUf7yP+PUWb/tlBTgs0cF54UVr5D0n002tqEF
 e1wE9wrXcJwF+TrESOfe3QI9Hw3ev+oZvjtG9nNZ5QNaIr6PKHTHCynZMEvelRBaFN0g
 r2S7JK8nRm2f/v5suULTw8166PqxCHCl3fIuwwAN2pyEyXZFmt7ekkYEA0yujRVaejns
 IcPrIRlDbkcToPJkPNSB0vXl6eGC0EBlEryF4PmI4IerhUBy+wVlZgVy4Kg0OuHbTvKg
 9ydXM9DQMGWbv1MTl5O0D6go6jjYz+fD+adNIL7Dp4K9nTpTxf3UFJoJrzlnKZTFxwl7
 2iJg==
X-Forwarded-Encrypted: i=1;
 AL+hErGmOz1DNifI7O+w0etH8uaZYSB5DDRL+TQeRjQPNrvIeRbQI90gv3TzgFOri3bMIN/73o87ePEhUZc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+OsQw18GmnQ/l3UqtcJtkZ/gtBFupWeRDiaazfpyafOWigIYuT
 HVzjoLEaiwKzr6U9tDDC7nOGR0etc9kR/4spVmrvx02dVMUX1znc0qAs
X-Gm-Gg: AZFdTZfG/U9FGT3xf5IvPa5/l8gSYrRD37wRItHU/ywJwYjwH9Dp90ciiJ+c2BT1WpO
 a5QTdTqRtzKIgPmhpXSVhvh7Zrt0Lr3FxZKTdkX2MbRIzb33Vzh8F0/7L1bmkt2Aycz1ya4Q9Ht
 E+L5HIE671XJL+keGiVIPr6lv2o3eKyaatGVSLc3Ej/+Zjgn5vWoiHP+EcO2JD8Vx38sOzkeKzq
 9I3RFxHDx7QnDyWGMK7xUNjEETsMpbjYaJTREWIVkF7EWaaF6h101sEMMiNs9LIA2kVmZEXdN0E
 W3kY+8BCoaGV+0RG1v8pw9KEQL6nJC+UmePbD+LgKPBzcpYlsR877vkJy4a8AWNe6vJeUNln8lP
 A1KOY+kWE4EJK8zvwBvllimkkhJmTUhp02bDyAHnCJqlxNLD4G/h4Lk6cuiRKENsSV3lSsvdbqk
 9ZCsAq9MmwWdMF9IlDSD8Kt+kWN8RhYhLNL6W7tz9dLLSNjdH4booN0dnSefENxAb3JxBqw2RSc
 lAnT1fzAfeAhBEp9ibl1GDEvgvg7S6yOkMoGcFrlJJyOXfB2C7OdQoxg2tZDiKMRCiH27+I7Ct/
 z1gSgtqHP57E3bcBZtzy1hHlZyBMivp981UHzYbussyeZxZ663+z5UGWIKZQJBhJo/EtmAM3uH4
 IeJa6mcLniWpGBYH0SZ/TXc9LSChBfU0UhKG/53T0bXqrBS74+1qZFqZCJr9BiSaWodT4iaJbCK
 gB
X-Received: by 2002:a05:6000:608:b0:493:28c4:331e with SMTP id
 ffacd0b85a97d-4a63ac6b509mr6786601f8f.28.1795021045786; 
 Wed, 18 Nov 2026 08:57:25 -0800 (PST)
Received: from C422HJQPQG-Fractile
 (cmbg-18-b2-v4wan-168328-cust3701.vm17.cable.virginm.net. [80.5.206.118])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656b1cfdfsm6052676f8f.47.2026.11.18.08.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:57:25 -0800 (PST)
Date: Wed, 18 Nov 2026 16:57:22 +0000
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: drm: ioctl: fix call to unsafe function
Message-ID: <av3Y8mTaRi7l-5iy@C422HJQPQG-Fractile>
References: <20261118133232.48603-1-vishal.moola@gmail.com>
 <DMYH0CXPUTMP.J3AKN619TL34@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMYH0CXPUTMP.J3AKN619TL34@kernel.org>
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 05:17:41PM +0100, Danilo Krummrich wrote:
> On Wed Nov 18, 2026 at 2:32 PM CET, Vishal Moola (Fractile) wrote:
> > diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> > index 64af9eacc306..5a2e2f4f0e91 100644
> > --- a/rust/kernel/drm/ioctl.rs
> > +++ b/rust/kernel/drm/ioctl.rs
> > @@ -152,7 +152,7 @@ macro_rules! declare_drm_ioctls {
> >                              // dev/file match the current driver these ioctls are being declared
> >                              // for, and it's not clear how to enforce this within the type system.
> >                              let dev: &$crate::drm::device::Device<_, $crate::drm::Ioctl> =
> > -                                $crate::drm::device::Device::from_raw(raw_dev);
> > +                                unsafe { $crate::drm::device::Device::from_raw(raw_dev) };
> 
> I remember there has been at least one compiler version in the supported range
> that complained when the safety comment isn't directly above the unsafe block.
> Has this been fixed in the meantime?

I'm not sure? I'm compiling with rustc 1.98.1 (48a229cea 2026-09-01) (Fedora 1.98.1-1.fc44)
which gives me no errors like this.

Hopefully the build-bots catch it if there's a specific compiler version
that still dislikes it.

The following command shows a few other occurences in the kernel like this,
so if its still an issue I imagine it'd likely be caught somewhere:

	grep -rn -B1 '^\s*unsafe {' rust/kernel | grep '=$'
