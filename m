Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C4606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEY4nQdQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4911A10E37F;
	Sun, 22 Nov 2026 10:48:18 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C4E10E37F
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 10:48:12 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5c0f0e04628so187208e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 02:48:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795344490; cv=none;
 d=google.com; s=arc-20260327;
 b=abkA2oTX89dT826fTVeNQHqwTPcR25qb2ro4Pj3fIbGYEZMhMn1Muj3xbb2PbsWD72
 AdwvMPKh4nyK5z4UR0iUuY0i9LuShw9ELMHaz8z1vaAXQYHx9KqngETB2UTAZ/e/5soi
 Ppd425xJ+Xk+2BQ8cI9/b+DY1O7LmfQKNE0KnmmVsYYpjLx/eHvwj54aaEIa0TqlH3We
 7Stjczzk1EIvlnhm9jIweBlBNM93OfR2vx/z3swnwpphLYuy8n0k0bFARGO1PbkvOj6h
 fRp5qIeFNlf2X+UP6v/aavYVUt0u6DUWVbO/efdhUE1vY73X+AGiyIs+cOAxMGCY3rHS
 m6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mhx1drtVssrwQUvFZpFBDrx2YW50rLKbvbFZpE3l9ZM=;
 fh=GlI7giAIuV2cTA0tmTooaQ3+9/ZEQkygLX8f6hZpxD4=;
 b=dEeELjp0la7xXBTVL1n95I7hXDFbTvQe+DaeT+0gEa6armYS3gN4ctLP4zQx35zydW
 9uo0pi/aKzzT/2bd2F/XJ/2paYpgItPx0X2U6u0t6vDeDrz2BL/3UVSrlu1nhVtdqDyP
 o7jZCD86dPmO/kqQMrWhQLlZwpikuhDttp0g/vQbzUOZIbhspl2CCBypLRH84ix+ObuJ
 8agtP9KKKBeUdEZBUWIe23O6/q5naujT3fAwzVs2WEXCgPVnt7pHOD/WyheJpY8pSB3v
 ubU5KQjz4xsy7Klaog7nXEw024KUnbIHouA/NsZYr747UwsshfQ/ZX1Y2lMf9H3QoZyN
 OW4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795344490; x=1795949290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mhx1drtVssrwQUvFZpFBDrx2YW50rLKbvbFZpE3l9ZM=;
 b=tEY4nQdQIvqLU2fC6v9bpvjG0B55HCORPnmuXH0vqxp+PEDyGZ6SHRAbAFmipbG+b0
 Hx+0TFVUfTHZiPmSiEyl/9dwdlHP6QhXMgsQnYSeTdrORofOswrAnnmaKiiVkYeM2ecM
 2RT/EtXf85rntQHpKMt21+hsXFs/GyJ/Em5F1OVEz4MjBNDBMRXcH59RSySbLwlLNZw8
 DHaQK78/NYDMfasL8j6gvrQgE5qznK2HoyJ1KkPxqVytbQrOQ0CO02X5v29S+JpFyodv
 G4YDbSl/Kx2uu8nIZFPs3BU98u7coXWoaqx3w1zxAHT4nK2NeBx3JLLHQnkZQCP20VGw
 EPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795344490; x=1795949290;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mhx1drtVssrwQUvFZpFBDrx2YW50rLKbvbFZpE3l9ZM=;
 b=VzELSnGRoEgdQNbXe1Ao3pxMbldY0TdcDmVrx4zarZDQi5lifn6IuydN9ybeDJ1m/p
 YWgzFZQkRCu9KJSnK9lNEQzlSSfgOofXSiMubGhczgn2TGXtF4iEGnkiX+G4YW4lLMfU
 URti5vdA6qTj+6VYR2835G0rdifQiJ6thzUkfxdTH8nYyc3xn+bUk3L3D/67kEUH78O2
 M2RjsX1jf/UjllVONO3fpTAFkZQpJuK/dmqDvM6L9vRymf/VV7iZ/UgN2b5t4DphFBnx
 t/fMnKBmzrQGtRPrc8jx6ZCghpvv0u6/DdcU14oguEKHi/JkbdvQPHWJmKjg10xNv7hd
 y8TA==
X-Forwarded-Encrypted: i=1;
 AL+hErG8lDWaZjSoRu4h38OO13HSppyDDIIYM10agcmAyd3dwuxsxgkG/QsdMSjHz3RCco3UeVkVYfuBswM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9RnV1SDACEGVLNGmPjN7sXpMnIxh1ajJ5WAYluUIDTpcE5Gx9/
 hiICudgGHKkgtk0HrBy7K5Axq0gdiJzUA7eOWn8vu9aCXor25++musy5yfjaZN9a9qRQ7z3lEud
 ysqJZE4ATwVBbFibaXNMoSOow8ppyUEg=
X-Gm-Gg: AZFdTZfH5Vs/ttqV7yiuhRvlkDSyytBDeA8xKPFrXYqW2pfBTSvCL5AFltSIXcWneHF
 HPmttXp2zrpMqniXnjwC1KiNWUZZFJCRB1JEG1manfcUv6ieU22kT1bMrtv5SeWC2fQeSq5GmRG
 dzXZruGFxnRbLO++rWAGgq4VwAvup02T3Or0bsy1AVt01HrYbYhUaWoUZDEO0vPNtN8L9faU33b
 JmK9jMKumO0CTYM4TxpGpV96Rd+FqqWlIluVn6nsAK1ndCBEvDEuolrWefHEe91H3Q42j+d88jS
 gJSu6fp/NGfxhRRVkJzkAyGTAs3yqnYGwUtFFAz2d1UpKNk9CSlDxRXD0TlfBFU/wUt0ygd5yZW
 ordueuLB1XiTaT6GKmrt50rQiPhOWAU66BexW/cJuehkfBLw3mCdL5xKjKoK1YBWMEGwtI5MDcv
 AFv39g7cTenpQ7ydSf/BXUsm1cLAXUV+/WVNZy4AVtS0pywhWRo43Xxzqhj7tWM/jdt64idftAW
 bfoPZyqdTkOOltppluvpojsUDloYeUqtASdRHtCWqeCcpPuc93c4v+eUNScJfDYJ0TPSf/J
X-Received: by 2002:a05:6512:4481:b0:5c0:ca1:46d3 with SMTP id
 2adb3069b0e04-5c1bc7c5ee5mr2148467e87.5.1795344490129; Sun, 22 Nov 2026
 02:48:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122072007.14685-1-mbkchelofficialdev@gmail.com>
In-Reply-To: <20261122072007.14685-1-mbkchelofficialdev@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 22 Nov 2026 11:47:58 +0100
X-Gm-Features: Aa3M54rWh-NrLJggWQJFn1aNreu1UxgU70djoLJk4S5LUh68VqdSv9UJWxdNb5o
Message-ID: <CANiq72kV0YwG54i6fLSv1Rwtu+3Ks8XUzpdkZohY5tiH6LzhRA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: gpu: buddy: store the allocator inside the Mutex
To: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Joel Fernandes <jfern@kernel.org>, 
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 8:20=E2=80=AFAM Ivan Tverdokhleb
<mbkchelofficialdev@gmail.com> wrote:
>
> -/// The inner [`Opaque`] contains an initialized buddy allocator.
> +/// The `inner` field contains an initialized buddy allocator wrapped in=
 `Opaque`.

No need for a new version (I just noticed this skimming around), but
please keep the intra-doc link when applying the patch. Or is there a
reason why it is removed?

Thanks!

Cheers,
Miguel
