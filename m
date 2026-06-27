Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D0AC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 10:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1E710E4A8;
	Sat, 27 Jun 2026 10:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aDQiy8av";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5169D10E4A8
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 10:59:43 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30bc5fa5a2aso117469eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782557982; cv=none;
 d=google.com; s=arc-20260327;
 b=p62lBqwf7S5tXIj+H5mgJBCKPzGOhgmmAMXfL7DdYF4TgP01+GT0drYT+aDBuXfeQC
 a8pBYcl3VtduGgOts0fj56Lm/fnQDCRnikZY5gimqYdADIXKGtq7MBWsOq3T4VilqlVM
 DrM8UDUFIFDqssmUtVnvPVKdZLLp6EpnQ3Gpe8jlB89SLXfTpaqU9EYs+Hgh1fM+337X
 b+eOQg9cet4vSDVuhKSe1xsdMat9x7f0rHf3cYSzlRBXwNQOrEXerKxP2HoaO2W8QZoO
 logzv3lKwVi+Nwih8K1exmrrFNjfoXnRF+b8WX688sfqMkdR76kH2GKZ39MgLj1I3Wra
 izYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n+nDLLPZ6wEr/4dq0uqyhXXPZoefpLj+VqCWxHyZNrQ=;
 fh=0bN92Dmt08Bu11fHXC1tNaYUTsfeH8BPgS0tpyYUe+A=;
 b=VEg/0eFYwM0WD0R9fwF8rDOFMBvIAYBUbggE3CkeMYVV+idtCasYeTFbDm6nKFuF7w
 lWCDO9hl2Uslyqc5yXLz7o3MtFPTQRZkshZ4bZOCHSG9znRFjFVhhwkDECDJjQYWEEO6
 b55unQ9vCCwIpPCqqG0ycZHb1THy+3kd4JVmQsXYH6GeFs5J176pv8pcDSpwG+hgib9q
 jvDwUR18dhw94DhM3REiXVxJLU6j5OrVMti9+tom06Mjp+PF8TV8EsPANFRrzbG5WkNV
 lOzjkuoOA7hUi+K562MMZYe17RLT6FYefC11c/bYyxLtp0zbs85DY503fPVeb6j1rnvi
 7UOw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782557982; x=1783162782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n+nDLLPZ6wEr/4dq0uqyhXXPZoefpLj+VqCWxHyZNrQ=;
 b=aDQiy8avO64YDquudAxQYC+jm6eIBKUjP9XjD3PRxnDChgHcE4ePz/rRK5q5N+/Zv1
 l5ltQbjwdN2/QqyJ3t7pM1OvM9ziZm/2FNlHZ0A16137Jm38dPAigosB76Nl9a+VzQI7
 y4nVTrmmhxaAgL/zaHzS9dT4m9LZQpcgXPrf+WTwD/dekdsd6mMWIKxjistfiyaUvRSI
 yj3eCFNUEkEuxhlzeAsLgkat/yMfpm6cWc0DK3g/vdONPrvdjdOmBr7R73h6/QHLG4C6
 gL0DglLeDaROIw6NCYWHl0PBUFH0dfsVl7G+rTNULdzBAhIn0wACuAMM6J0+l0f1pn6F
 JyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782557982; x=1783162782;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n+nDLLPZ6wEr/4dq0uqyhXXPZoefpLj+VqCWxHyZNrQ=;
 b=Akeym/Jiqc1EenXN0ov3wfwphBVmGe0B3t1k+4uoUBcr5EHFNU3D0fV3HgFNrO4s+V
 vUsxyeTO+eXofsOvY4tRkztEm1EZ4w0H2gyyLydP/eiQWXULiZNt4h1lIFv4keSF7ays
 9zRDWgNj0bElLBWeKnaBTKRtpV5XYZXoGg1IU2Xj08W8uCC/yE+4E/VqKLt0UmwLUPnp
 8khUfO7DmnGLZdJN5jq8tyzV37nkM85oWHQgUMlEqIf4tuQPVIb+U+KbS+MGO0YAZDIW
 zAkRY+C+TBijsyChLM0YuXZPB75LYbg/JgKutLtnaXR8/e+KMmNOTx92gU4GO72j20qW
 qRHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RppkjIYsY5D7rJ3ATvDn0s28VYzaF8VInJFCtcAgrNb6pj9EKxBmBewdDFE/X4rbq3dbOujUFLBjww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3DDdMZP++IwFAR966GuyCncRrUbQj4WOwqpNHW13ly4VV490M
 XQhA2gJq/QTxj2Z1iEhHdN1p9slEl6qjraVdWkKwSWr5VamJ4hsTDym/M7ZC1Y+D40DTKc+VAid
 kmspeYplWSQIccDIYQEWlUDfBbaqyl18=
X-Gm-Gg: AfdE7cnugEvGkT440Zq9EA0Rzq0yWbdZ7Mf4djICkMp2KswTHrheQRKjzm//YA3kzBj
 Nkgale8ZDs5JJO/HKggngw+plHXg4ITmoA16ekM3KumwSjPo1+JnL1M0BIJvH8PfpVA2+jtH4zC
 Tc7AS6xc9duPC39UTLy2yN+BhRmakMY4736BvJ/UsbljIpJFXNTF7XCuVdTmULQOK5X7cU1yL/e
 eT1FSBBZrjx+emR5zwJqS+CGQsPHFcrLQimXFsl5eno5WqU4n+TMi+h5uVtBFXrxmUCHUCg8H3n
 U8elxZIgZn0nx9HYaWzUbFy/uMuqvh1+XxHs4z8uJ3YEtG2rE9urQHaC57ep1HAFZ8afR8YkY2I
 4RD6Uguepl9/I
X-Received: by 2002:a05:7300:6144:b0:30b:c021:5045 with SMTP id
 5a478bee46e88-30c84ce60f7mr4014070eec.5.1782557982397; Sat, 27 Jun 2026
 03:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260626183630.2585057-1-dakr@kernel.org>
 <20260626183630.2585057-2-dakr@kernel.org>
In-Reply-To: <20260626183630.2585057-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Jun 2026 12:59:30 +0200
X-Gm-Features: AVVi8Ce3MkIh0ONlyKuy1KTbQ-yG1BEWeg6mkrKBipEfxJFXZQzFaNA4SZvKL0c
Message-ID: <CANiq72mT0sAUX0Ob0RHzqS3QOzRxkc9=UoOuPTTyH=nAa8D40w@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] rust: types: rename ForLt to CovariantForLt
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
 tmgross@umich.edu, acourbot@nvidia.com, ecourtney@nvidia.com, 
 m.wilczynski@samsung.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
 leon@kernel.org, daniel.almeida@collabora.com, bhelgaas@google.com, 
 kwilczynski@kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
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

On Fri, Jun 26, 2026 at 8:36=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Rename ForLt to CovariantForLt to prepare for the introduction of a new
> ForLt base trait that does not require covariance.
>
> The existing ForLt trait requires covariance, which enables the safe
> cast_ref() method. This rename preserves the same semantics under a more
> precise name, making room for a weaker ForLt trait in a subsequent
> commit.
>
> No functional change.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I don't see anyone else in linux-next using it, so this is likely fine
-- if we expect others this cycle, they may need a merge.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
