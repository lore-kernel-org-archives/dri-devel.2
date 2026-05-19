Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAACCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E8710ED07;
	Tue, 19 May 2026 13:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s0ueLN9O";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE28A10ED07
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:34:28 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2ee4e75bc93so236996eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779197668; cv=none;
 d=google.com; s=arc-20240605;
 b=bJ++nCiLtjlDcuHrKnv847GGwspTLzm11msrFKMCTwfv94gy+ZShwQUdAEdAJ1HznJ
 LUbiHUGHW9lRCpsJu5QoMkd/SweXsw/TU6Cf+L+FAkGWFawZU7vn9NzuaVZkcG6SHHKC
 TdfmP/XJoLNoLUHiMmGVsN4pwX9Xda+raXWFJ+6+dzA2+8j1fCs27qjdVO3KwN/+raVB
 12TQwpI510rNk/vZT3i/2RzZZ5WUebnrUXCPKqnkLlSHoN6eN/RT8No35Zr+RU3pzK7x
 kYnKUP0YPAT37J7ZDXJVn6S90EWwbEcmpJ5HyrlS0S0olF2at9WusShOtL35CTu9ALnU
 lH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
 fh=Yfpfs5k/sQGbFoQZgv3O17wilsM8SssYqBh/WVznDBk=;
 b=I92FPe9NZAQrDkDDmKShrOQYyae4ygNajHW3JxZaG502VuNR8yqd8A9TtfnDqq9YlC
 j9mpwweyN8RTw9Kdm/gGORpI8oiT7eeMyQf2yWuKHNz7oj/7hgn894g19z44Qpm2jR3m
 qTOETvHjAcRz/57u2XZxSFKJhUpElm5uqGnHnF0F1tkm9ELqJxaWWH19lVP1Aw8j+Iql
 RMqPGW3ShSJhS8zXIOmsdVjJzP2Ncvslp+EGrpvXL/tsPJYshLFD5bb8AbsXx30g1FYh
 WhhFuLCMXCwAQ4V2C9Sol/JKzhphoPrKy65avtTkvyx8fK1iutdw0xGYDXBODVf+cyEJ
 GU5w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779197668; x=1779802468; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
 b=s0ueLN9OtDgJPQdlpOLXZmNf3zxoo76kfWAZW1p4XE0sAmpBfcQbiFS9Y8JVvfrG1g
 785AIFNkFtLPkc1Zm0iahZ4DpmkpfkrlpPyXqHi/yscpCV8NWAe7vwBo/Q+RCkXzxZwD
 +PJIiVfiLaJvYn+4By3/avJ5t+sz3yg6AkNgntw21ozGaeRASHqAUNfvTDaFNHSeMOYh
 TI7iNE6+1h0ZB7DR8YyFO3gaBDdOiYB+nq1WpcIvCspB3S0iAlyLNWhE/NvWehsUP9uK
 R0bSRCZfI3wPiGubgUA9716jRH+1Kk2eeJ1muJQHSiVtX4U3baDdMqMpHvU2gyYTYmS9
 QjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197668; x=1779802468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
 b=iHf5EMXNFxu8hOzqlmFORpY29YlEAroqSLvcGotcBwqTFDoFvkQ1LUOcsD2R1dyRBL
 lAehPX6vhlEAiuAZYKM2W7eUauFT+cD1xP4FHQwTYnpLdXoA9tXFVkpRqb9309qBppt7
 fixP/rDlKILbOYHhWPY9j3MkeSbIuBQNoc5TAt1DnHsOpXIhvWj++Fcj3UKqwD0GYVCD
 s6CCb8arLxWAuzOKiEjJRuFX+RYfAcPFRav95S9qk5F+sTOvgE9s72ds8XtbTfU9kd4T
 VUzMTk3WLNuI2JS80zQYF34qqzKtDalSGczCG4IGhcBMBWryHJbP3ThaT/udEU2poP+O
 Gvzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O2P7gDWwblzaE1oQZ3cZVYBYD6OBJ0tuUBJA2SX6xDWSwf/N9zR+wi8V2FDJAiB1i86HY+FNDW6Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwW5ZYxzwMEpF/EnTt2gAMhGNzZ1t64eICpQIFA1nc0lZ69hmAO
 4arpykNBKnXQJeSbGeagCeiufOPmBkPvZnJlfARL8Dkctm88MZLV3GfccjaX8/aATuPA9l7ik9W
 kxysyX/HBuxwnKwzVFMiivLQ9/BVgmU8=
X-Gm-Gg: Acq92OGrBxck1qlKE8qjWwiNYzAQ52f/BkvWT7IBsQp2FDIwVsJ04GSW62qwg0rv/r1
 KdNcASNY3qvTIaaCapY6tgvePHfD1/XlmJ+slp89QR6OhFwlGgJIG6qodkdfaAYvftj8Yxu2/Rr
 mpjEgPC9aSmfUeXY7T9uxYqUJ1FWcNXIcrR3xCl0SpflXWzzoaZIt/BDSBH9nabPkU1qL+bNaZN
 49UZx7abkF6s1MjxbquL72vD5MNvPbrsw3cEYC6Qsb7sbBCWOjeg/sNLY3QTpGEHKJqRxjI6i54
 X5EGSg3TivGmHw0uMNK1V3N0JC4yKkOf3OMPtA5cf9q60O8CKhJfYgTqFEgjWSaIinN0RhfCVlZ
 MLjydXLnPMjE0p1LIZdzHfCE=
X-Received: by 2002:a05:7300:dc14:b0:2e6:b55a:76ca with SMTP id
 5a478bee46e88-30397b88952mr3989391eec.0.1779197667973; Tue, 19 May 2026
 06:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-17-dakr@kernel.org>
 <DIMLSVG1IO07.28UMFL4GTCQG4@nvidia.com>
 <DIMMHPLUV2LK.39WF9SGO8TLK5@garyguo.net>
 <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
In-Reply-To: <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 15:34:12 +0200
X-Gm-Features: AVHnY4K5vpbJGhCh2fM0bDGLH-gDIENRDMeBQsxYOoXtqTcl9WixZ1bWmTIZnkI
Message-ID: <CANiq72myVDq9oLyyZqUf3Se9-JLDp=qGhBJy01nOxMaZBRxADA@mail.gmail.com>
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for higher-ranked
 lifetime support
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Alexandre Courbot <acourbot@nvidia.com>,
 gregkh@linuxfoundation.org, 
 rafael@kernel.org, aliceryhl@google.com, david.m.ertman@intel.com, 
 ira.weiny@intel.com, leon@kernel.org, viresh.kumar@linaro.org, 
 m.wilczynski@samsung.com, ukleinek@kernel.org, bhelgaas@google.com, 
 kwilczynski@kernel.org, abdiel.janulgue@gmail.com, robin.murphy@arm.com, 
 markus.probst@posteo.de, ojeda@kernel.org, boqun@kernel.org, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
 pcolberg@redhat.com, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
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

On Tue, May 19, 2026 at 3:03=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
>       That said, I expect LLMs to be (heavily) used to write drivers, and=
 LLMs
>       are typically trained to be compliant. So, I could imagine that a p=
rompt
>       along the lines of "Can't we make this work without unsafe somehow?=
" leads
>       to an LLM abusing this, while going unnoticed for the user.

Could we steer LLMs to avoid that? e.g. adding a line about `Unsafe*`
items to Sashiko's prompts.

Also, a `checkpatch.pl` (or similar) warning may be doable too, since
false positives are OK there.

It could go to the ASH (Acknowledged Soundness Holes) list we
discussed some times if we end up adding it.

Cheers,
Miguel
