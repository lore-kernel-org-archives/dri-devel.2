Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B29ACD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7011D10F79D;
	Mon,  8 Jun 2026 17:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DjDSnYJ7";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C8810F79D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780938629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jvziielmBQRhjbGDR1LkdWpDfix4f9jfDw9HyW1EWo=;
 b=DjDSnYJ7HWxlEz7T7gW4TnleXiL2S7diO3rRzNESSzOR+FL9sNeYl9ikYzmqICYBvu7Y+i
 J3FtoaEyFY5r52E0n8ZuglHQuPiBWBVITzdc6wQvBwd9adrPtnvAPnTPjYQOZK2AxHGwsG
 StMADEm88HVrC1M3FEFj0ptOa38n+to=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-DYojpRNrP8-ckzMtdZl2ng-1; Mon, 08 Jun 2026 13:10:22 -0400
X-MC-Unique: DYojpRNrP8-ckzMtdZl2ng-1
X-Mimecast-MFC-AGG-ID: DYojpRNrP8-ckzMtdZl2ng_1780938622
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91598ab3a1aso687155385a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 10:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938622; x=1781543422;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jvziielmBQRhjbGDR1LkdWpDfix4f9jfDw9HyW1EWo=;
 b=rvD+0glaaaUlkesN3Q+e/NLdWzkBZLZG68jGfhiZYWzR4pPFRbxGqE0Vaaw4A2YWeT
 701+ryF0oT0eRMiIEBxDsk4i54B8uhkDZW/33FUKk+FKnwpKg6vuwGyyegSEKce5Iggb
 pTBDwhuiGtfvYVyNzKwP8J88E/RtwPPkulZo6xKfalsh7HIz27vOFpiZu+IPSxiagJC4
 7sX2xehx/K3f3034iLCh3nAFuDfGTKLGjvEBpZ5Kb55CDWWh4Z7SK4m3Uq1mCW56mGDN
 giPVtQO3v2SO/J/AlKXhpWH7CsBUk6qaVfSZkkmuHfoTEjRjXvduHyS1zlH/ArsHsrBx
 ExBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FVUX4p95CWTpGDmVqqy7XBYYubZIH75cbcRHJOVrm3avfq+CjxLehDR7klyUOxQuXmku5mfMjfts=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPjD1jPveQf999aHL9oX8oxPJingzMBl62ngAWHFj3erQnFR5O
 xtwrGdQ0OsmOBctlWT7xgkaeDiU2lH7JQkNE3OqDOrHDCxpHWn2qxe6xiuX5n0IMRSm513IgG1L
 zCD3RdZ2Ea0DcIqOGpKJKGBwXOjlESCuNmwPjF201SbKcTQpgGhxt9qvNoJNTtbcSbbnXLg==
X-Gm-Gg: Acq92OFVuB1ltzyRFGKy/OhQms6DMhNXHG8NN+HlarMtuMUcjz1TxOpvFK1gv3Yxwki
 FA8sTXtrn+AvoVoJOcKDNWdMG0OZZY0NazF2+shCUbN9eRL2p89GJeteit1HNcYBcKFQjCAJmWn
 0BPfQiQT4+L16u2heziud8fGo2nBcZTLPa0sDO9uffX4rZl3HGRzsI8NQFgBGmAioc4NcNA+96/
 OgeVx71BVUVh7kpvMIQGGOHps0snpeWYDI3Vj0MUbxKAvGms63vlyjH/R2uSzhsA0VlaQ06bRnE
 3zxxknBBrkuC/o8fdBXxNavLtjsTJWWBi3Q9KJ0NsTwVBYGifiAYk53lk1RMJIcisW1srV07thr
 LZHBiG+bNUUyG2I4C/h9D3RjW380C
X-Received: by 2002:a05:620a:254a:b0:915:9943:d760 with SMTP id
 af79cd13be357-915a9db892dmr2520128085a.43.1780938621382; 
 Mon, 08 Jun 2026 10:10:21 -0700 (PDT)
X-Received: by 2002:a05:620a:254a:b0:915:9943:d760 with SMTP id
 af79cd13be357-915a9db892dmr2520115285a.43.1780938620617; 
 Mon, 08 Jun 2026 10:10:20 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3bf5f9sm1822479085a.35.2026.06.08.10.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:10:19 -0700 (PDT)
Message-ID: <00c7a09eac169e9da541b50396ceaa69ae978c10.camel@redhat.com>
Subject: Re: [PATCH v18 1/4] rust: drm: gem: shmem: Add DmaResvGuard helper
From: lyude@redhat.com
To: Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Cc: Alexandre Courbot <acourbot@nvidia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, Miguel Ojeda	 <ojeda@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Alice Ryhl
 <aliceryhl@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,  Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Benno Lossin
 <lossin@kernel.org>, linaro-mm-sig@lists.linaro.org, Danilo Krummrich
 <dakr@kernel.org>,  Mukesh Kumar Chaurasiya	 <mkchauras@gmail.com>, Asahi
 Lina <lina+kernel@asahilina.net>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Mon, 08 Jun 2026 13:10:18 -0400
In-Reply-To: <DJ2TB5AX540T.311A690IK8F9B@garyguo.net>
References: <20260604192740.659240-1-lyude@redhat.com>
 <20260604192740.659240-2-lyude@redhat.com>
 <DJ2TB5AX540T.311A690IK8F9B@garyguo.net>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xf8jumhrW71_yn4HGVioedfCFRqCtAxF68-iT2uWYBQ_1780938622
X-Mimecast-Originator: redhat.com
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

I think I have just been defaulting to always for anything that seems
like it should be unquestionably inlined - should I be defaulting to
#[inline] instead?

On Sun, 2026-06-07 at 13:22 +0100, Gary Guo wrote:
> > +impl<'a, T: DriverObject, C: DeviceContext> DmaResvGuard<'a, T, C>
> > {
> > +=C2=A0=C2=A0=C2=A0 #[inline(always)]
>=20
> Why `always` here?
>=20
> Best,
> Gary

