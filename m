Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74184606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 04:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkrefraction-com.20260707.gappssmtp.com header.i=@darkrefraction-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MiM5ytXV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703B310E056;
	Wed, 25 Nov 2026 04:44:34 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AABE110E056
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:44:27 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so9042147a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:44:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795581866; cv=none;
 d=google.com; s=arc-20260327;
 b=kAtAqu9fN5I6OLUJjw2R3jNv9HI6FAsYZOjiEvl+TKJT6Z/e9Dgn1bB8p8GvHCRKg9
 xIyT3y9F79nvtarqCdz1E5cpeRdUNvifRp5sn2e3ZuskgUvYEpUyp0V8tIimv/F59WnB
 pee7St2fBEL2PRpnDGLiMoDzII4puWt9bRcHd6rv2WI0AoB1hb3lI7CPr79Ws8Gufl6H
 YumrNGrMtklNkPuM67D5aInY3c7k6754okl0BMHslZ/Ak8GQsV2bIqudj1UYUhKVZHZ3
 dGi8w2aku0cGDP951jsKkLR7MCcQS0CK2Isi5I/wBkXl+Y6DHJAtodCXV0bR3FwL2jyA
 gF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0P/Usw7+gp/Bpo4trnNxkJUQwTAy5fHr0Bs9XaW/gFE=;
 fh=zRJCTIPUZA2c5hm+wvEkH2na58FWe8Hj0jxfBAe+BLg=;
 b=SrdJ4BP3H0aWm0A91qkiSpWkiz0nRA4ff1ZDqM+MdZhfPdiaoZa+ir92xZJX+x/OCl
 dTTzCh+wmz6ycJqCzii6VqEn+6QgOUFfe3OFW/sDSGmheAlKjLZEOjxpfLFyzvqRjMbg
 iCoyiY8tbLQmD3UtXw3sfrMzpeZRO7qZ+Nbk8GVbc+TcfcH+UYgG5nL82ynW/kL0k8jT
 7Ra10kVwtZRgAPMnq2TWc2h/3e5dWTTWey3/YlCOr07aJourG4snb54CO1BacTEpGQy5
 Raozn7/gzIMd10suKRDgRBsBwJTHw8SIcM6DA8L/gDn9UBj3XAWD0nmNic1N/d+M2oGh
 smEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darkrefraction-com.20260707.gappssmtp.com; s=20260707; t=1795581866;
 x=1796186666; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0P/Usw7+gp/Bpo4trnNxkJUQwTAy5fHr0Bs9XaW/gFE=;
 b=MiM5ytXVVAj7u7B4hdIkPSRWBJbeTP8o6Mggq6+GnXnF9M4HZg9+9yCFNWxj8Fy+V2
 di9i6IXNd5s6d2VZN6IQ3QmCzNAEwqQpN7blkCV4qtMZlzGpBs1t+8r/IlAsCbhFhCyh
 826+ZnI1UZ2bUQwhEhkMCDstmtx4JLf3UufCogto/6nOnnVHGBGvVJn/eVuuWWKO7HDl
 61Zt+v3yd7YLQec4IL399IdWtsb+5H5AEtQOs42EINrNVc79LocW6s0VWO301OoJJgj5
 tW5PLW2sVOC+pVL4pyzk5wK9SJDhZoyIhP4JJMNy+2BLfC/jhKnlu6gP83ZMmxXjsFxN
 P09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795581866; x=1796186666;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0P/Usw7+gp/Bpo4trnNxkJUQwTAy5fHr0Bs9XaW/gFE=;
 b=0TvHbNolixpF5MV39cQSgsXMZRlMEi8+gPpV20Rwax+I/9kP/E5ZnbFvYkaJW+ZOxk
 vW0GBwtXbBAlbglNa0WuaTDuPHGyic+gwhQuuqb0+K+Ytaed20415SJjiIc9zyfmPIKM
 wArzQ1uXgW0AFtbII5H+qVx1GT+aG3C3r/QfXMb39VCsCVobSQX9DAiRLeLZPstzu/t2
 BQDov5Z4ZAr/ianvZN5jVRwuzt3XNqEvDz02osrhPKA5NZZqupQsMqWNrCCOCD2vmh+L
 73N8s+GixCua3s1w4HUyn2JpQaRO9GR3qK/Ce58rPYgu77yF822Nim7PGt1LGzgewYLA
 CZ1g==
X-Forwarded-Encrypted: i=1;
 AL+hErFE+jOceiSp1Kfpl+UvWfWtFDxQU0w68ZCcsFnzMLaGhPEhl94WVUoB0hAhqPDZgQCodwQR7Zkq/Bk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z805P6t0Ih/rPOjmmOMeyWaoaJ08BthUxEZKdAycGFjw8fPVA5k
 zTmKBefwBFyS0PsIBDqVQnoRR4K/snbnbWvmJS+BaaDVpiMFT8Z5jHB5bqBbq/Zbnf814PRZzne
 wJnFANRK7gmOlo3wNbxoQf3hG0VJwSBkTSACsfg+gsQ==
X-Gm-Gg: AZFdTZedomd/fQQuShECVF4+SmMt69OUL0OiJM7oqhdDm/dxod3hO4buC1Ji+wT3lkQ
 tqZGC5HLUOXiiQiXh0pKf3ddRfHezUkve4gx5RB4kObtOZguYmG9bKDwHFhf7Oblff38cd5u3z5
 +OdzShUwBaITJOy24TdBzzG5oGQoLGhhDMdXcOZnMAq+dSzhuUz32mwKkSkWhYKTg8OW8zIZrlY
 ETsxqhQDADJ+lW6/8Kal5Fcn0OKO5DYOnCcIAzBUi9lDWNpt7VgXk7wj9c0qQzv0W0AwF/XwFs8
 ia1pjep59+rFv5sug4tjv4PVGR+s5oGxfuh4a1QnzPbmpGjTRaDzHnMPE5o+V/M0H+JAjKqyLze
 w3aa3N7C+CM6qLT1M4d79MHDxSzhYSkmSClP1ePJ8QVilimU71hNr8WtTyvpa2diFcow=
X-Received: by 2002:a05:6402:e8a:b0:6ba:dd2:7660 with SMTP id
 4fb4d7f45d1cf-6ba37ea54e2mr12212519a12.32.1795581865793; Tue, 24 Nov 2026
 20:44:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-nova-nouveau-gsp-v3-0-e1440479ded6@redhat.com>
 <20261124-nova-nouveau-gsp-v3-1-e1440479ded6@redhat.com>
In-Reply-To: <20261124-nova-nouveau-gsp-v3-1-e1440479ded6@redhat.com>
From: M Henning <mhenning@darkrefraction.com>
Date: Tue, 24 Nov 2026 23:43:59 -0500
X-Gm-Features: Aa3M54oS8z1bbZenOaASI7fGSdwFLpJbJd4Pid-wIEEd4ioU315GAzjwqnmrfoA
Message-ID: <CAAgWFh2VmmZfdEM1hDB+8921ktfRrD81kXFqEc6dJ3ys+=vJYw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/nouveau: add option to leave GSP-capable GPUs
 to other drivers
To: airlied@redhat.com
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, nova-gpu@lists.linux.dev
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 12:50=E2=80=AFAM Dave Airlie via B4 Relay
<devnull+airlied.redhat.com@kernel.org> wrote:
> +config DRM_NOUVEAU_BIND_GSP
> +       bool "Make nouveau the default driver for GSP-capable GPUs"
> +       depends on DRM_NOUVEAU
> +       default y
> +       help
> +         Make nouveau bind to all NVIDIA GPUs by default, as it always
> +         has.
> +
> +         If another NVIDIA driver, such as nova-core, should claim the
> +         GSP-capable (Turing and later) GPUs instead, say N here; nouvea=
u
> +         then leaves those GPUs alone and continues to bind to pre-Turin=
g
> +         GPUs itself. nouveau can also be prevented from binding to
> +         GSP-capable GPUs at boot with nouveau.bind_gsp=3D0 on the kerne=
l
> +         command line.
> +
> +         If unsure, say Y.

Maybe the documentation should make this option sound a little
scarier? Right now all this does is break nouveau (unless you're a
nova developer),. We really don't want users or distros turning it on.
