Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A394010F9940
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A5B10E686;
	Wed,  8 Apr 2026 14:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LL83V/g5";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5068F10E686
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 14:20:15 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so416569c88.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 07:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775658014; cv=none;
 d=google.com; s=arc-20240605;
 b=HtAClSL7mASkq3FyApDQtXoT7O90QmJNfUXoS2U/CDuYxWTAqpd27Lr8AGtmG4ihhn
 DG2UkLAKSLVGsCM6koBOM0K3J69XJQFYqNQt1yg0AATsBrR0BwNKx6P7HwueWpZOb2zH
 30cajcel55iYSI8xRLuztZvGH5HNoHyuynvhUKAWlxGmPp39yukhupHIlHhKOaJpSJVq
 VwQz4UFyJirb/o4CLLGhBsxbIf33gO2HKmQdyCFIQko4OMLxZcBLPtGuZnUq65EQOt48
 feY8LSDDuXOgTVHt05YPBhYGyBK4tbAwA12Gx45I6lISJCrOwqW8xmLZZiUHnKHb+1xE
 Xk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q1y+smlCqz6n1PMoDlj18aKIGcOgfg0UvI/ylZY44Cc=;
 fh=hiWb282/bq2ygTShIC0BMM9gCECj9rtyCgKfIVktXd0=;
 b=eGOiSHzobMGOLu2kMXk6TB3AFrPoept4aD9hkO/wNeWRqzcHe3L7iaUaXy2GJNWj8t
 Haal90zxv64DKp2tY+Nw65DCmeNaAjfRKajpIqRB5oIJRxEtrKyoa4fT2OQ9i7Aft0Wo
 Qrwwly3ZImtXvpe4JbngsJAkYnDBQ/vCnj20wKs2RiVTvuw4dt3C/AsVMS4LNJ8UnIs7
 uFADDlnwasDUuEz0BFclg9GhILCVkcWPxvr6ODcNgYDRtI+9UIj+G0+pjhqK7UyoLIWA
 nX/BTE6y1t06AmekSKB5MW5VbQMc4vvqDX2KBXzAWQtnFbIbRXYcZ86spalAJiCGTmUh
 miyQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775658014; x=1776262814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1y+smlCqz6n1PMoDlj18aKIGcOgfg0UvI/ylZY44Cc=;
 b=LL83V/g5aTua3CJb6Wsl+gmoQHkV7V5DgLSoJQVKPIWzDWMwYMv0X0qS6LFQrzK0D9
 Kn5ARfjXoxkCUwH5hcsnpIWRpCvjxDyt5OLzonxrkQIXNG0MpOMRDob58uybF77gIK17
 RNNCKkQiyDf+VjXP5739aqJOY5hS3J0Nsho8PiBxFGi4eQ1nJT/4dVPHM6Uc5tnz7EtJ
 rSBS2LQ3Ak04WFU7jVcZaTL+rz8B7mt5EHlYuDRaLr+nNwCu8H7Q96dlbFxK3RMRJIyq
 9id16Uf+SogmFVODmERfVeR48bUHgq6WUlxxNzY/PFQO+r2CPAaqnpN5fN6QW3erxlWh
 k75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775658014; x=1776262814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q1y+smlCqz6n1PMoDlj18aKIGcOgfg0UvI/ylZY44Cc=;
 b=nJsjbtV594xrx10lWVRNeHO4JPcj1qhncZa9pcW2jDYukqXiAJU+Ps1rIGRvowjSxz
 6cbuhNnVwST4hh9eC4iLLDo/66qbas9xxiMPLZviMLFCmvwboehlWB2QDi19swomf8Gi
 C9CZR9ZZHRpvxag5WntIj4iqZlkD/rNUua5fnF9OQ5LYkqTxS/JDuM1vOrYXmT0/8czW
 DilHHY+iTR+LwDQO2bS+hcXR4+80vRi8S+oBQ87oiszsOMKPhqXooQusYgp8bngR6ZEj
 pADc2idbApaPHZ5+EW4jSFBDLphL0mVvKiIFTYlVZfKzBpqWGm1pPwqlpB4bCN3WAH1G
 JaGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLQlYLUpVxHXAHUgeD9HnI5Vjx9GC1ol3YZxUjyfwy09lpIzsEmeZSx7rwuRK0gwvHaQMiR5AL27s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5jWFwGENiIP3HhUno8bIokpTVWHLRNDNlSPzaDt+3gdJEyURv
 oE5odNFpo8eeOn60RNjw52m8aadvwcb5rKinaqO5OnPWFGhNhYlstuZ8GKytGr0Ib3bktlSdAiK
 vS7dzOHpaP9YrqSEZU63+HWt3UxLgicg=
X-Gm-Gg: AeBDieu6QYlLMZF/zWa/bb3y+Qnc84rh7WkEr5E3HdKTml2XzrYkQziiL85O5gwt7lK
 WS0DkQmL/YzpGFjtcBqmDPBjvbcAPbUBhv3KUpox3UxGdLm7yquP8BD4AjfgoGaUzENkkQ13VJx
 3hVsbmwqV3QAdaGm7rPmE0lChfh3czqixD1rEzZDZfrCE3qs6Q+FXXtp6P1Rr3l2j1FIcL6BZNe
 +jMDbNUM95igpLOFd/QqZr99QxzBy+xMJaSJQ2c8NwSoGrpX9RKWWrSSv7nclFOzE8rji/sWKjP
 hBY2C3/RXReUFjEGFw2WbglmWCDOd15q3u9y3fdcNc8xYVYHjKYfnqQ+dbonYKS3LuDj4fecLOU
 EDoVYZBXxIIysTjDFU49y+YE=
X-Received: by 2002:a05:7300:cb15:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2d2a3326e32mr848566eec.3.1775658014213; Wed, 08 Apr 2026
 07:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <adZhzvTbFS_usXsX@sirena.org.uk>
In-Reply-To: <adZhzvTbFS_usXsX@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Apr 2026 16:20:01 +0200
X-Gm-Features: AQROBzAiXlALOfRiF_JjMpOGPv21CFKTBddIthBewffEZSTj_YnbCtPNzasCLqg
Message-ID: <CANiq72n6OWKLPomKTcbg=KXWMfkJgowWLAT264kSBwVwSvuz-Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the rust tree
To: Mark Brown <broonie@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 Asahi Lina <lina+kernel@asahilina.net>, 
 Danilo Krummrich <dakr@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>
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

On Wed, Apr 8, 2026 at 4:10=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> I fixed it up (see below) and can carry the fix as necessary.

Looks good, thanks!

Cheers,
Miguel
