Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0731BC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 10:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349D610E110;
	Sun, 28 Jun 2026 10:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g7wACHDW";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A94F10E110
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 10:00:17 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-139fc95b7fcso4713c88.3
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 03:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782640816; cv=none;
 d=google.com; s=arc-20260327;
 b=SJ0YCYAR6PuHFECCVMpQCFCZRDPR7zIhaRgLkElDecSlNy08qkpg8OV6u5HFkeQaKe
 AfcgbI0VKFDdsR4NnZq2s8IkSfSXvc34Jyne1/v1GK5D13klDewffaDaqi/qKVw1Wm2/
 B1AhVemQqfrq1RWSSgOja36XJ0roYUC1nSkHAm4XN1mxU3h4/QuBfjdhXvzG4KMH7EnG
 yX4yy78wKFPgKaV9aOwkgBgkxpvI5IiGWbCZb84ZknaDjzG9ssrCf/SQA1UjWYRs8qiX
 6UeNe3RHHHr6T5re7zPashlVsvI43pPLWpzNX/PYQByNoWQnD8wPLpXR8rjRDgmPITWm
 81iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rKOr+bOPAaEop+QOsAuBUUdGUuxOSw34AqHhAUajUjs=;
 fh=q95WaTBXEksxNm6AcecgedH/Nj5jW6kBf9sX8mpkaGo=;
 b=s45e01hgNvXOfnn4PWFwBR9gJ1zB3A4CEKRJCYgMa8iy9pjB7JZv+p56awiCWM+sWe
 4bSLDJRCPcqOTnot2Q5SWbzi0mQVGzVtkIKDbUqqupQZOrsnCmy1zANJplaOxNcHhohI
 lNll6LpnSYf/ljBCEvwy9yAQiLO8xU6tsFT+3ckZTNiN1W9RHTpbsqVZH6rYywQ+WoWH
 D9smvW9FvduoScWsGCu9kPQ1//8WXJO1ZdL5/1s1Uz/YQUcP8nQzC0ZF6yi/Lgk4Kw37
 0KSV51LNFKtn2qknbDhG3FhpPT/ad38W9xBkgk1vBvFqO8tVamPg/91+l2WWRwVZTgvg
 kFSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782640816; x=1783245616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rKOr+bOPAaEop+QOsAuBUUdGUuxOSw34AqHhAUajUjs=;
 b=g7wACHDWOqNBrdpnp/ZNUQ3U4trGzxLB8FkKRf5mBpPj+y9CBwAUZ0aTyayTSBR8gf
 BcmDz8datxeVsGzDGr+ZTCs6huKvxFLTnEV8i/q+3s5Uv9AcXbRbvxMG9dgVloVAkaIv
 3MQTp48XwfrHNgzoCVpHLnv70M+Mm0huqveytf/h2+dW3TGPXflD4V4qEuQsqM+W18h4
 u3AggqveoCH2VhURXLODTtZLKQMQ7KGBmBnNwKnQkT3r6JFhvYTTw+z/FKiiu24oDnWK
 +ynCrgaweXqaATbYPdgGjArpiXepIHNihnqDWZssa2lRZyAHtbb6IGnYU5gxV/u7EOtL
 bKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782640816; x=1783245616;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rKOr+bOPAaEop+QOsAuBUUdGUuxOSw34AqHhAUajUjs=;
 b=EssgARHgOxHc57mOmq2tqTtsBbem+esmVqv3QEhXL5gGMX9t/Kzl0ujrzXQPbS2Bhj
 Hr4IzqmkgEAa1jsymmRzv2GfTjR6NSwgCDtVzzm9ZPaYnZPJgNKsyY6u0vmxwE2DKn5O
 CqxNVLDj+1GIVqKhdgvwv/SVeSCWndjzknm/PTIcgshuGmJT454wB8L4c68HLMKBlagU
 1PWHAVFsBDA2KPihAn9EUL+/oFJtf/II4AoYG7VGoCe6e3+Oh3d3YaPFzS9V9GjelZTI
 PcQSrdnb0XwnHRgNLwQPTrejJh6H7/wxDPxtLeVCodhbBEWb/PILxJZbXiV6w2f+WbaC
 SGew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9hwZFysI1Au0bHlTRFRhxp5SPXT3w3uS79Vv9s0YEOCKE4vGL1kINqCbPCnf3AkHKLLO6C/x1RT0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxPY3lQR12RcCCPEc1Dd3mqRJfe57hiSfTq7ncZY35r9biJJFs
 pojXb95PzKGnTjAcveOkM0fTyXdbv4zI4jobaC/yJwzBGrIEnGVBWJVfkoCKL/vEQhhoOaWcCmI
 8asSw7d0+l/EI12fQYuzAmDRlL2RXwBo=
X-Gm-Gg: AfdE7cniZmU/fhL6VVhpRe/TpEDZu6RzgKDXtfo83FYEhKDLPtSaKTYm20U9AnTTh7+
 nSvUawi9e6sm92PbhebH8E9auM8lWmFbhbuOyfvt/1rs3bAYt7xanfO9qvlR2Etbght8lX8qZZc
 GOcPJMSoQ+O0HniVzwlTAFaECyD0XtZHzl/0GuCkFtd1yr40DU1fhveXVAUhzvC4xBY8BZbI9MJ
 KC4IKWq6D2/zFOW/0NwAdzvSRv5kLMP87mB6XKb804xzJgPqzYIYQDGOTWgSQsh6NlIcIWoSJo7
 7iJY8KsYG8oNp4n/K4A5brn5JVJK0937HGixbQnVIwdxKK8PdI4O+Cm/qnq/jUzbKEYZV00kxgC
 2bCJnzRmeTGyB
X-Received: by 2002:a05:7022:459f:b0:138:2790:149b with SMTP id
 a92af1059eb24-139dbaec420mr6043173c88.7.1782640816464; Sun, 28 Jun 2026
 03:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260625205146.5047-1-niyudi.honda@usp.br>
 <20260625205146.5047-8-niyudi.honda@usp.br>
In-Reply-To: <20260625205146.5047-8-niyudi.honda@usp.br>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 28 Jun 2026 12:00:03 +0200
X-Gm-Features: AVVi8Ccn1HJ8X_hAz1-AEqOSd2k8M8FF3q-xf_jEPBCIJBTgp3WrHNp6qT-BDlM
Message-ID: <CANiq72ki4YkLKUQw-iR_GcF_ernUvN75m8VdHCeWmQh8Amy6Ww@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/nova: remove unused trait in commands.rs
To: Pedro Yudi Honda <niyudi.honda@usp.br>
Cc: dakr@kernel.org, acourbot@nvidia.com, nova-gpu@lists.linux.dev, 
 aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, ojeda@kernel.org, 
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

On Thu, Jun 25, 2026 at 10:52=E2=80=AFPM Pedro Yudi Honda <niyudi.honda@usp=
.br> wrote:
>
> In gsp/commands.rs, remove unused `transmute::FromBytes` implementation.

I would change the title to say something closer to what you have in
the line above, i.e. "removing a trait" sounds stronger (which made me
look into the commit :)

Also mentioning the trait name makes it less vague too.

(The formatting on the import is strange, by the way)

Thanks!

Cheers,
Miguel
