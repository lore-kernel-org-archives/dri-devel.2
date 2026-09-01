Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6E4C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 04:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E6B10E3A4;
	Tue,  1 Sep 2026 04:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ui2iAm1q";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D022F10E389
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 04:54:06 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-90cc64570deso7840506d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788238446; cv=none;
 d=google.com; s=arc-20260327;
 b=VsI/kQROICn+NT16ZBhol5dPymAX27FeGiufE/A1ZRG8VzfNEmdbe3pK3my2gqoyze
 KhsagkR13DoXq64b2U5iHnX3xCl78TAwAF0boAyS7SR9lYUggLLwD/nMxG9G9gFWI0ZM
 vixbbLTkywnCxbLkvo0a+ny2xauq71qGmGQzs0v3a8nAckifW7VLTJ8D9H3SKmWtpqzF
 SqEqwTYP94W5g24ODZKyXVEcy6gJ4oNU2Oam0pmgXQ62pm8sOS+IMOLmCgnlTkbbus7l
 VXjiHc7LRfVqDttPFAcwF2TOYizNMrECtio2FqJlc17kS3lQjF3IjL2xBgXx3wEz3ZeQ
 YXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8SuycrJ6e1WFHR/TNYgsJOBfzYu56DYt41F/4NfeqAU=;
 fh=2aSMCMlIN0CNynYZ/X1hga1kG6RtVewrrsMT/BOBp/A=;
 b=XZ9N3y7D5DyNMKW3kMDpXwfU7mSZx9XSdc+EHWxO/8vrCB1Ja2mzy8IhPhCpA5biRO
 23coWHCkD2tcOYt9eACWIbkYny76RbXe9fRAkf+OPx+Sb+MOMwR+li+va4Bf0hAtAGWG
 Hdb1wdcDCb9SmEPEgGFhpnTn5VFOXc4uuKeQOrDLSECROJ0foaizH68GzppW75vjBdtJ
 +qenetQVzW9rZ3MTwDnYlJ0wSp1+9+GoX8m952DQqbW6L96w3YhGhzbPANmdrfndbLj0
 QF3hKyEfI6meTTxoEouwfqUjVuqOjzNZmU2RVKYL4heflyEtBh7H0u0+iNGDx4I5MHP/
 w4Qw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788238446; x=1788843246; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8SuycrJ6e1WFHR/TNYgsJOBfzYu56DYt41F/4NfeqAU=;
 b=Ui2iAm1qh9GHZ5hwu+zBctQiOSfOjiSOIv28jjOHvAdjewlXrDg+budKfnuZhbaOqb
 CvjUBR9Acq559WYbWd1znLr3gO5lPik722jQYGMAsj8cdlqr4V1LiC42283UgAcE71kl
 Cw7A8o2prUj2anMS4xeToCReD0lFeV+UpbqG1fxGrdu4T8d/QVAKShEndY6smUGMs34b
 t83rBGUTFaNbJSvIMeHu3kvwBpa0F4px9Wxxaz161w8d7oN9bDncIp8qNlOBlecRJwj2
 a5IGqdmY4Ri9BpEdCwqD6Deasn51AwERa3SwGtBcPfwV1rxoECv5cGcUUUbyS0iL2z7t
 J3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788238446; x=1788843246;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8SuycrJ6e1WFHR/TNYgsJOBfzYu56DYt41F/4NfeqAU=;
 b=mK+ECuHpv7En71xtueFuPlwh1QaYaT4x0gTP/L4AZsTseRLnpivmj7rpBPhGug/ujM
 gAArBo+yX6D3JooCL6XE04m/L2c+N/eQPwLTK4mbAvk+5SItftEcyBiRrg/poEHwrPV8
 Xjxvtzkciyskl/ZbzrvOFKCor+FawoNwAULJbu6ztGaTjYFi6YqQgDckVzs7WPZhbu98
 3ds1kVeC7ZnX28X1L0G03bilWPXidbTSlo7la/HIUSJfkqFsqLY8E/fu0Y3H2OTW2uBV
 WPqPTgFDhhgkbVU66/03hkBQvh7WqGe5UXJrAPj7Esuq+AkyDXkpNWTvCf5OOazmE+vB
 faSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+qp0Ryq3K19ugvVoXTHBMrD6wuNdVC7nNQAqH4+DyjK5nN2YDYopH5NjYSSC/b6sZWxFC9QNqq9M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lvuyIXHu9yF1pT2rqpul5gZnk+DqPiwCTFcZiVg6DbsQnOEsXk
 akzydSrFdE7OEotHcYvXuqGKTQZL12poMcco345yWX5UMtDZ81J4eLw7FDnc6z4MmfVdkMfAgs5
 JqIUM8QnKiemWcL/BbIqXGmQ/AcNh3qA=
X-Gm-Gg: AYBFou0i08jLgYy3XN/M82jhulWAtlBsKKwfrLT0bPtpqxqfkLNniODYG4rSsuUdO0c
 3F9iRuSlCqPYVTsBV6Mr/u7DPYYGpXnRUrA7AMJXREh4nu/zLmLbh81QzSw89O2t1A8QUn3gfLd
 nST3hh4DSYZbieBSqLC2dESVnoUN8UwsLEubyhPJ8V85mjh1lU7W573zlHCOjdJY5xdD1oHAMQb
 IHQLCkkpVcy1tXpUfcsEVP4F014nQFduVJ6x+p8NZxHeLO/LiUNRLIQY23w3qoQtlkh95SL47/E
 xBqa8wkwGUgvDQFp3nnmI75XQghpTJdMPOiYI7Bbkba8SOHRvaNIjLv7OatFNY6nXALjM4oiI11
 Kb9M8m3M6zeruMlmbNIvuPd0K47fwIEX1L8tOqNPY
X-Received: by 2002:a05:6214:5d87:b0:90a:7f98:15f3 with SMTP id
 6a1803df08f44-90e956e7aefmr37476106d6.2.1788238445773; Mon, 31 Aug 2026
 21:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
In-Reply-To: <20260828033531.1117754-6-apopple@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 1 Sep 2026 14:53:53 +1000
X-Gm-Features: AcwNN1Ud4VFQrRun_tYvFTt-qwucbEEO3S9gIfzjiQyf2D1HVIdudvpKJIZc7pw
Message-ID: <CAPM=9tw6nv7UbMvKOGSsZKKwoZwCG2hvwGk=JjmsxQcH=wGfqw@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
To: Alistair Popple <apopple@nvidia.com>
Cc: nova-gpu <nova-gpu@lists.linux.dev>,
 M Henning <mhenning@darkrefraction.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 28 Aug 2026 at 13:36, Alistair Popple <apopple@nvidia.com> wrote:
>
> Add an extensible info ioctl and use it to report basic GPU information.
> One of the first things userspace needs to know about a GPU is its
> architecture and implementation, so add that as the first field in the
> GPU info result.
>
> The ioctl selects an information type by ID and writes the result through
> a sized userspace buffer. The kernel truncates results to the supplied
> size, allowing information structures to grow and new logical information
> groups to be added without introducing new ioctls.
>
>

This is a higher level for the future, I think we have two paths for
getparam type ioctl.

Either we expose a big struct full of values with a add to the end
mentality or we keep a long list of value pairs, and userspace passes
in a list of value keys, and we return a list of the values.

I'm trying to think ahead towards native virtio context support, and I
think having the sequence,

open
get_all_infos
create vm/channel

might have the most optimal ioctl count but also let power management
avoid booting the GPU on every open if we never create a vm/channel.

Dave.
