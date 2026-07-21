Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF7C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627CB10E38A;
	Tue, 21 Jul 2026 15:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oo0DK3La";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0694310EA53
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:11:24 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c9d1fc053e0so6977832a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784646683; cv=none;
 d=google.com; s=arc-20260327;
 b=bqLP0WQu6G5XIbiC3txg7uTFQlRsoy/dwQBUgDRaHEVtSP+ZgIVuC6TXS10ClBgfRb
 l2F7pqEVayYmNVR+CrYjT9mG+1XHt1mf9nKwi+Hu/TURV7DFsG5yBFijA3kuFCQ/uKP6
 YfdWusO1GrAPQf57eUQ31knCxjCDwb7xNUmCM51LWh5A/xoe0RgPxWsgaZJ9bxJG4oKh
 WChx6pAYqkfzKyQJVPKadJiSufZuT9+e20mL/CwdhlXGGKepTNxpAbrmBoF1G1795kWJ
 Thst2S0WTEdfdNdcw7YBBik88/QJGdb70E5Gj0yJQVhMSHP+aWDqn8Oofu0XR7OkUhqV
 UYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/sVJ5iSKzdGNeBFDX7R3RcAFMpXgx0svJwjKK7cYX5g=;
 fh=sSnbmiWQxmMjt6MWv/mfl7zpHOdOntwnXAH2qk9wwFE=;
 b=SGm14awFK7vqfDUiinqa8A14mgs8xFvH2nRTPP6Wg2+aRPVFYolChr1mbN3qxrNQuR
 Kw9SrcXyNGI71XEiIjHaZAQqvpgbzSfOjdrTy5UqsJvq5VfEY5/TNd1nNg+WGCg9Vv/m
 u31tni2+V2gJ0aYjRWnB4VzBrsLlMyTYYeiqBaRwmH0ivE0sth3Jp23dNjht6c3lwUS6
 6UUHVtrNOaDzC9DoQWZNzdd0UMH9YUwihiDuUkSc/NdtWP1QVtKBId6RiSis8DiHpaRJ
 zh5ErzY/WVCKLb16rrIRM5Dx5piZm4k809lm8HJ8VU2/fAt2UbIHxuob28H7BwfgqzU1
 yMog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784646683; x=1785251483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/sVJ5iSKzdGNeBFDX7R3RcAFMpXgx0svJwjKK7cYX5g=;
 b=Oo0DK3LaSBpYHvnbmx618EkKtMnwC/26QLyL7oUVaAgbibDV1sz9PBDJOHvG4O5HWb
 bVIczyIswCWIMPOiwA0R3q5bsAY6xI+u8Vx4RSeIndnWf1ly3LVTrYGjhw0VPIi/F0/9
 YCyj46Eidixt28c49p8EVVZWXnJjLu3Urjo/NG3GSHCCS5a68jO9KDF3juix0PMTNDrb
 N8ZN2W0FJ+LOGj6RnG6i7GFvHcX7NqpFVKJIo+1bxB5O4VS2CS8S27bM7zv0e9vhUO7Z
 WxrnH7R04atvo4iZniSog8FesW17aEqcjBrFbaA2MPI38dXhk6drKFTRLGvfoQrUig43
 4J7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646683; x=1785251483;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/sVJ5iSKzdGNeBFDX7R3RcAFMpXgx0svJwjKK7cYX5g=;
 b=G1ScOsLjLgZ76WZKsGZ8E5eOJx5BcNkXdrUtT6YHkmScShPbW/PONNC1rOZopbuBix
 WNTkL6b4vu/Un7VlhYzpOC7iBae+aBgiRkcu90MtDVzHY2mEirzFBklq2MK6zviI7qJZ
 DbhxGrj5jWve7bAVIjESFb1b8sDoER4zeqOeasmv09W4jWpL3yDATVHwrnWiy08gzA68
 eQ+dFqg/HzaZbXhz61Zj05hMv0nWS5AtwquKg6ffz9eFX9axcYHwNs7t4zGfp7mdehej
 Mc/uj8MRX6JFbuFienqKt0MSkYlhf4ItNFL4arT2mhHBunKE8fKixC3BQcNF1dxju6qx
 Z2SA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9WEAJjxERksEBDnz5naurqVM9nrInbyp1RR8vjE5jqh/NpYQkBskjXsL2Q6sh5gZBjpjPHc8oQtQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwP4z4qnRHwygkD7KQ5/tkMEwHJpEcr1d9rRjdsPxx3ANnJQ2Wz
 11j1n62+wV0Rw1uZtHuvQUN45YaLs9MeGB9i/M8rvZbKWycnRP+2FH8Ji9UdVMwqrdNsakvowHY
 IRN/UbfwrGbXld1VKNml9I83B3kT0RPo=
X-Gm-Gg: AfdE7cntWHvEv6bf5TK497p27s8WLLnjnwYUcPOGoQA4Qif9a6a+zxMbqEOYm025SYw
 GGB5XIw4omEivwpi2IxtIe77tsm423y6Qz9Cp1zDfj+iPlY2HZBd6Ph0cg4/3CsAG+Sgz1c5Vdb
 kVhfxhqtnS8gtIw4/GKJw+FMbKSIAMGCwhAFi33SfOC7VNi8eVNifRBP58rw6Jl2mYd0hqcuU+O
 FnvgRgyp6uL3kMToTyWm0YtE4dAQOElA1d7orzgmYtseGQnwmn77hDb+SQ=
X-Received: by 2002:a05:6a21:6b16:b0:3c3:a0cd:9d27 with SMTP id
 adf61e73a8af0-3c3ad66ecc0mr21127535637.26.1784646683254; Tue, 21 Jul 2026
 08:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
 <e0cc44dcc3efac7f354ce9a6eba1a9a87a1b096f.camel@nvidia.com>
In-Reply-To: <e0cc44dcc3efac7f354ce9a6eba1a9a87a1b096f.camel@nvidia.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Tue, 21 Jul 2026 19:11:12 +0400
X-Gm-Features: AUfX_mxZoKGz0zjXRIRk9EUOyjgsNzY0GmvxHJjHZRY3DRl5T2oCoNvbrDYpPsA
Message-ID: <CAA+WOBvMAuuxiPec0wNVzPDDrr5jBwoYpd8r46VyKk6hZOVnaQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] drm/nouveau: GSP telemetry via RUSD, and fdinfo
 telemetry exposure
To: Milos Tijanic <mtijanic@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, 
 "lyude@redhat.com" <lyude@redhat.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "mary@mary.zone" <mary@mary.zone>, 
 "airlied@gmail.com" <airlied@gmail.com>, 
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "dakr@kernel.org" <dakr@kernel.org>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
 "mripard@kernel.org" <mripard@kernel.org>
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

On Tue, Jul 21, 2026 at 2:39=E2=80=AFPM Milos Tijanic <mtijanic@nvidia.com>=
 wrote:
>
> On Wed, 2026-07-15 at 01:14 +0400, Mohamed Ahmed wrote:
> > A section that has
> > not been polled yet, or that the board does not support, reads
> > -ENODATA.
>
> Per hwmon/sysfs-interface.rst: "All entries (except name) are optional,
> and should only be created in a given driver if the chip has the
> feature."
>
> It feels really weird to have a bunch of things there that just give an
> error code when reading. Does anything else use this pattern?
>

The power_supply sysfs group does something similar to this but this
was something I was not sure how to handle and wanted more feedback on
in general. I went with this with the logic that it would be similar
to nvidia-smi's "N/A". The other alternative was going for something
like hwmon where we detect if it's supported early on by probing
everything and latching onto them and then unsupported stuff is simply
dropped, but that approach felt not suitable because of the polling
nature (if for some reason we couldn't latch onto something, it
wouldn't show even if it were supported).

Another alternative now that I think about it more is that we could
block for up to 1 poll interval if we get an invalid read, which would
eliminate the transient errors completely. This would leave the
unsupported items and in that case we could return -EOPNOTSUPP instead
which makes more sense than -ENODATA for everything. It does still
have the tradeoff with missing items having error files though, so I
am not sure.

> >   - The sysfs interface exposed here should be stable and valid for
> > nova as well.
>
> Agreed. Please allow a bit of time for us to review the uAPI for Nova
> and future GSP versions.
>
> >  RUSD is stable and only grows more fields with newer GSP firmware
> > (e.g., fan telemetry gets added in r580), so it is possible   to keep
> > the same interface as we use newer firmware
>
> Don't assume this. Work is underway to significantly rework the RUSD
> layout to make it extensibe in ABI-compatible ways, but there will be
> a single large ABI break compared to 570. This will happen when we add
> RUSD support to Nova, so it's some months out still.
>

Understood, thanks! The FW ABI is fairly insulated from everything
else in my design so the upcoming compatibility break shouldn't be an
issue if nouveau upgrades to that firmware and the main concern is in
the exposed uAPI.

> >   - amdgpu offers a single binary blob with all the telemetry
> > embedded in
> >    addition to the sysfs sensor files. This series currently only
> > exposes
> >     sensor files, but it is possible to add a similar binary for a
> > v2.
> >     This mainly offers a more efficient way to read the telemetry as
> >     clients would read only a few files instead of reading all of
> > them.
>
> IIUC the reason amdgpu does that is so you can take a self-consistent
> atomic snapshot of all the telemetry readings. That's just not how RUSD
> works, so we don't need/want it.
>
> We don't want to expose binary RUSD to userspace while it is unstable.
> Once it does become stable, the way this was meant to be exposed is to
> allow userspace to RO mmap the buffer and read the telemetry directly,
> with no syscall overhead. But I'm kind of loathe to do that even with
> the new format as it will require some parsing and that's easy to get
> wrong on the userspace side and still work in a given version, then
> break with an update.
>
> We can revisit this when ABI-stable RUSD comes, and then maybe have a
> reference librusd that does the parsing.
>
>

Noted, thanks! My original idea was 4 binaries (1 for each poll
domain) but your idea is strictly better, so waiting till then and
revisiting this is a better idea.
