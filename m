Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA9606A333
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fAtDFwpB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A890110E541;
	Wed, 18 Nov 2026 15:55:44 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C62510EC36
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:55:38 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso934409f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795017336; x=1795622136; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=opiYjd9kyePy56Loel5UjRPuD8cH7yPxU8I5WOGrYBw=;
 b=fAtDFwpBoD3H8Lg2nhzwXirg9Akwm5KnztZBNbOH195Zv6D8DAELbHYAAMGr6VEH0X
 gFde5DmzSgORh7u8B/EScNlHBkyayVDCfXN6kr88ZMMftEJiG1nmR2VIfjJjtLIX4wjR
 v0IZ/AFZyZVCKh6MPNNpmPFUqlO14A/TeKf+pr6D2XlxrxM+j2voDRDMza20nep8vtyE
 oUWcTAxRtSy7/sxrR4hwSdcpn4PK+4XtM7V9beDSDtykyl0902iyUOIxfPZvRC/ArDst
 62kqZQpMJrIghvtC7wgzDR0ATz8Cu0I75eCEXocKOLIMQvyCjy5RXVSoIogI5YxNjcri
 Oafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795017336; x=1795622136;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=opiYjd9kyePy56Loel5UjRPuD8cH7yPxU8I5WOGrYBw=;
 b=be7ws/jhQsa/3wkfxitBes2KXMHjE7A7sHQPmxIHXakaWLxEw0GvDi1HTl1DynPW/u
 FONxOrE8QYwbk/EepX/N0kwlVPFgz+u6U1UY+5IDqcfF8/R0BaTFn66KG1ZV904tjhaO
 W4uZxIyiw7OhuQR+GaEixFv8ONco4ueWx7vX/fUyTviYBEW+gj1l8NS6miqDxZXmO2xs
 Iega7or29eeNn2PTjMh1oLDoWy3tkJ+GpSqJRqzZXJDy20MGW8zvlNJ8o0O2eUGDUM5C
 ZbVWPVaXceUphfP1YKL5yuWSBvzQVcwJ27YDXYpMhGg0WosE0wLBYod0kaE9kjv6Gaa0
 8xLA==
X-Forwarded-Encrypted: i=1;
 AL+hErFmcbCj9/BevO/EHzu6YuVHN4JRD44HcQyKdhLxO9bycGWZMhxQJHu9/zrGs52gtCFp6s2S3NfuhK0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9FW0c1qqN21o9JjGV6e3Af39Hezf9u516sAcTZFD6pEGnR2yjH
 QeabW46ZzzPxuJlGSQZRQna19uEGv+7G8cPzGu2uNvDHyWa9g/B5FHgd
X-Gm-Gg: AZFdTZc6J63DW6aVJTQxHtRChB9KFHaHpdNsaIiDqTZkk46iaLJl1aFE0kSbnb1KV2o
 D7K1ovrJdgSYYRz/O/QTj/kpgkqm3UFXOjE6TAkCz3r544sE+141GMBfHxzFy52cB6TEy0KhMKG
 W/1ydLkw4XTpDDehYm57nDUqpA3D3qi9ddt7Y1AR/TdDps+lNV/C9Qxh4OqAdtO6DPOr4yZLgK0
 3bHMoXp3KLqqw6VuEzuIHeIpv3uasW8PgTwk4NzQ7Fbl17tpM/M5PQlAtspguIP28WNN0FyKM7f
 OeQpNvw+5Bgld2ONZmLereLnxxeVfAf/7gyuKi/ybZb5gPI2l9a3r8hg1z0t5/eakf7DCjJukCI
 QolTIUMQXxnu85cHYcSMe4Q5uahyAYe+8TO9+4eq2yjXUaRwMu+Awv2buVlBCIGQu/6WuPl5cBZ
 6wkindWyH16zmRw2tiRcnTBcqpVUzxAfK4il12jsnY0mgyW202WENjYp36vqfyOQnPGihJZWg1j
 6OyOFd/2rpZEW3yRi0K8nGTqbLX3gvZkoYIoMNSRzKFbvEMAKIZDLjs0CHz7J5hickD//3VWCfU
 DddDPT/YYYzcn7uRVSxBxgUuPb7NuEA1o8FbDyrOnH4g3aCDpouac4nJGPO60AGwgrcz7V3ezUG
 YK/ql8jE4pyYVm0zXe2qBJLkzAcuP8OmkxAGHNo5AW6YnmHQqKtH4Zt/DBibs1vHjnwBPAjSAVZ
 np
X-Received: by 2002:a05:6000:4102:b0:48e:3bc4:a367 with SMTP id
 ffacd0b85a97d-4a639ff61aemr5650397f8f.33.1795017336371; 
 Wed, 18 Nov 2026 07:55:36 -0800 (PST)
Received: from C422HJQPQG-Fractile
 (cmbg-18-b2-v4wan-168328-cust3701.vm17.cable.virginm.net. [80.5.206.118])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c406sm5490881f8f.14.2026.11.18.07.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:55:36 -0800 (PST)
Date: Wed, 18 Nov 2026 15:55:33 +0000
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
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
Message-ID: <av3KdRxCJsek49L7@C422HJQPQG-Fractile>
References: <20261118133232.48603-1-vishal.moola@gmail.com>
 <20261118152901.788942-1-aliceryhl@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118152901.788942-1-aliceryhl@google.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 03:29:01PM +0000, Alice Ryhl wrote:
> On Wed, Nov 18, 2026 at 01:32:32PM +0000, Vishal Moola (Fractile) wrote:
> > Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
> > Signed-off-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>
> > 
> > --------------------
> > Based on drm-rust-next.
> 
> Note that patch commentary needs to go after a three-dash `---` line
> rather than `--------------------`, otherwise `git am` / `b4` includes
> everything above `---` in the commit message. No need to resend just for
> that as we can strip it when applying.

Ah, I never realized the tools were that particular about exactly three
dashes. Thanks for pointing that out, I'll keep that in mind for the
future :).

> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> Alice
