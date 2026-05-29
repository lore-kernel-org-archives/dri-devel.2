Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476A1CD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 01:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A62410F764;
	Fri, 29 May 2026 01:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ibY+a0CW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3303F10F764
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780016449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBRO3etB7lPkL1yRU0UjynsOCXgaIULKhqql2Fq7OQM=;
 b=ibY+a0CWsblI7BryN//b4u1C/4T4uKaYczA58kfO9/MgBZ3hTfofEukdspv2qqeN+wxUfv
 QS2yg2HIGo6XrZRCgACtC/guuMaIfFBkVPoX2QYJCCPHU4WA+LMi15c9yqkmUAoI6nWunN
 7N6P3EVGMltRzGi7c+MCdRtAAvHyMls=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-N-phtCMeMfScViYQ9658sA-1; Thu, 28 May 2026 21:00:47 -0400
X-MC-Unique: N-phtCMeMfScViYQ9658sA-1
X-Mimecast-MFC-AGG-ID: N-phtCMeMfScViYQ9658sA_1780016446
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517288c4ed0so16121381cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 18:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780016446; x=1780621246;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PBRO3etB7lPkL1yRU0UjynsOCXgaIULKhqql2Fq7OQM=;
 b=h9DCIRBVPunUQayiTkvydmWlg9tcLYYODBaiwtFLSuGEDlultJRlsqHODVie9k2Ow2
 Bx3DYIBvQZTXtU3D47Q10RkuJaFXAbAakybrDBcVPlJ7ILNXZpAPR3Im7F21U3W1l3LX
 56iRpGQe+BfhP5s7pKAEzQxvezo33sAjS1vt6Xsk5scOfiSzfAx8pRIk57xtHPQnJ8fh
 AF7qU1xmqV5STv5jCVaEPW81pHGaso2qxV7UkxnCijDs4c6lYIcmxbDZgCRmhMnSNQtt
 r3Kf51hfmGl6JY6AUugH8oJoB51gwjsb2gAT/QYXxVPXmlzKsx8da3H63QYb1GrNkGUw
 AtjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Jt0DQead1I0a1xNnpVBMACouPERblmJfQ9W3/1o+nxzTNCGtswuG7lktXvDHVw1oE2al9FvcRFtA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4wdN/Ik8mcJTDNuE4qzWPJwzH2eFkFzMXWxi95VBgJPGiOJaM
 yjFHRD9M79tycIMe1xsXLEtlz/xn4hBWS+nxNOzRJXLRQRt/m7YPSQx2A5/jEhHz9w99S2nZ7TW
 XZPTqx7oqfG7VRN4K+xzR/G9lBv5k2P1MSycK3VCx/k7/G7DkKxg0bOIptJLR4wY+soL8IA==
X-Gm-Gg: Acq92OHM+1fLabWODl3gtTFUo4FmAzsvppZbg245dPFVUI3oj5HVs20ADXqtysbH4yt
 k6nbOf5aB8sOrabmZIAZe++XZ/kh0FviMTG564/f289kXUmUomCJkJChE01rUcZ++MbjT60+BOY
 KxkbO5FRkSyc1nNs3HusqmdeAGjXtJYKqRwQ8pn6A5W8IOOdTw/imvPqJxZF1NlgIr/9Q8DcLAP
 JVXC5le5NEe2VZKSNh7vAYsN0lnppEAzwMide6390trRB+nc7u0oZFkNpYioLNcdxEgnqu2G/AN
 SMVUCV7vA3Swdy4Vb7E7f/Pj40Q1J6O++g2yvk2coxu6H/ivaF6mziOHNkG0ZDC7ifHpRzxHVNy
 wMIg92L06aJo8eTUjLJfKDcrcoeFt
X-Received: by 2002:a05:622a:1b2a:b0:516:dc50:a01a with SMTP id
 d75a77b69052e-5172dc1e44dmr12443141cf.5.1780016446506; 
 Thu, 28 May 2026 18:00:46 -0700 (PDT)
X-Received: by 2002:a05:622a:1b2a:b0:516:dc50:a01a with SMTP id
 d75a77b69052e-5172dc1e44dmr12441761cf.5.1780016445788; 
 Thu, 28 May 2026 18:00:45 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5172e9a5034sm5068741cf.6.2026.05.28.18.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 18:00:45 -0700 (PDT)
Message-ID: <066ef2f147aa7b568d31983b8ba4427c3eeeaea4.camel@redhat.com>
Subject: Re: [PATCH 3/6] rust: drm: Add RegistrationData to drm::Driver
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com,
 airlied@gmail.com, 	simona@ffwll.ch, daniel.almeida@collabora.com,
 acourbot@nvidia.com, 	apopple@nvidia.com, ecourtney@nvidia.com,
 deborah.brouwer@collabora.com, 	ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, 	lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
Date: Thu, 28 May 2026 21:00:44 -0400
In-Reply-To: <c393d06629007dc9fe76224d7b8a594b10c07edf.camel@redhat.com>
References: <20260506221027.858481-1-dakr@kernel.org>
 <20260506221027.858481-4-dakr@kernel.org>
 <b1865396f13f67b600f3548caa8ff907cfee9403.camel@redhat.com>
 <c393d06629007dc9fe76224d7b8a594b10c07edf.camel@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z7T5Wv00g-kn_ow-TiREb6EX3-1dbQXXDKqSZc1hb7g_1780016446
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

On Thu, 2026-05-28 at 20:15 -0400, lyude@redhat.com wrote:
> FWIW: now that I've noticed this, that might simplify things w/r/t
> what
> KMS needs here from DeviceContext and allow me to go from modeling
> DeviceContext around 3 stages (Uninit, Initialized, Registered), to
> just 2 stages (Initialized, Registered). The purpose of having a
> separate Uninit and Initialized had been to workaround not having
> access to `drm::Driver::Data` when a driver performs an atomic commit
> before userspace registration, which would be a big ergonomic issue
> for
> implementing a lot of atomic KMS callbacks.
>=20
> But if that's not an issue with this patch series, then it probably
> makes more sense for me to respin that DeviceContext patch series to
> reflect that since that simplifies things a lot for the KMS side. For
> your patch series, it just means you have to replace "Uninit" with
> "Initialized" in the next version.
>=20
> I will send out a respin with this tomorrow after working on
> respinning
> the gem shmem patch series, since that shouldn't take me very long at
> all.

Actually - after working on it a little bit more, I think having the 3
states (Uninit, Initialized, Registered) is still going to make sense
for KMS. So, I probably actually don't need to respin/change the
DeviceContext series from how it is right now after all! Sorry for the
noise :)

