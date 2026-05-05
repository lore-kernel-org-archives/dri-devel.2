Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7DDFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EEF10E13A;
	Tue,  5 May 2026 12:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZOCldm2u";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A57A10E13A
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:17:30 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12db2e9b5a7so491788c88.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777983449; cv=none;
 d=google.com; s=arc-20240605;
 b=ST1kX2AD2UhoB17CdM0yhN/Eu0snHQcEgwPCDRui0hjQlSNLWa4iUenEBumSUx1diy
 CPp4ugHrAmLEZfT2RXKl4Bh0hH4oGU8rqHTY2mh9RleBKJ2IeH5dYAwTyBRJ73P6DvPw
 kPFL0o6feY4K3tpAaNn6KRnMzX5NDpYEPba8pzelVA/qQLR2vQeZWU03mA9BRYXRjuMg
 QNdEDaPJQbY5i9+IhApmMKxIO4BD/tsx5Q+a+wAYyS0iRz0EBZcBl/sfS1Govy9JYsSr
 93uLPJFf8mMIujPEmFdwBlwMS1+fc0Ynb9bglPYS/gmVGYSBFNlIeplCpqUyyxYrHcuE
 /wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rh4nSzvUJ2lYZMblJZlYGda5GtEsMiN9Q4Lz0K9myNo=;
 fh=d+CJbLN5vEFQgSuTNOsWlS/GXg5zLs6Q5vVwKsN6etc=;
 b=DK1/UfNbrX+oHt5hl7tMO+pLxtRR4ANAq5TE3u6clZ3F3kpoZ6Z3sXbjLoI8NFN/+k
 GJJRAnTMuNmej4DDrixZkMQ5SJhxZBsBwVpu93P5rypel75ifTRu9shGvryZz7FjQsoZ
 xE+uVag8o+bbBmx+UjsMW3T/gdIKHXXuemUCqBMwXV+a8ePUpapGpPnQWuIJgBNTu8+a
 1VpHCCHFQs6rDMkuqSXuJ8ZGW7EYYr6cLp/7wqPbNiHaeNz/CVN6/YLeU14+IFzsXsYd
 YrV3+egGIh32YoIMgp/8RUjVlHAKOCyevTY7PbjeGSeanhGzWoEUmWjY2G9noDzqEdgu
 bSLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777983449; x=1778588249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rh4nSzvUJ2lYZMblJZlYGda5GtEsMiN9Q4Lz0K9myNo=;
 b=ZOCldm2uYHLAoNVmdbvfEywY05mcrECy186l3M+6V440bEQ0XEFHTZgldvaYSsv+fc
 deaC6+ItYSJAL/BFAm6gjlhcQMNIjup7/I5T3YIPD36T8LxpKG9+F78wTbykTDsOsNuS
 vwtonQO/8YIyM0kgY9VqotKFy4z7pgYLqiEk8dpMNe+5F607++fN9C2DCCo719d14pNy
 meMsZqNfyb91FIAwfNY76TUv+ZXTfsFXj60dDiiv0Y9U2uBWplq54Hvm6HP+RRE3Z/ZS
 5H3fPs0tBzKWy4/bTEzjpLmF4m7FvVPvsvsLpC8YRE0Jg7OvYPXCioCnOkrM/Bm2tSZi
 nwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777983449; x=1778588249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rh4nSzvUJ2lYZMblJZlYGda5GtEsMiN9Q4Lz0K9myNo=;
 b=tOZYf9YD9FK6B8PXz2MXij9kmUT62S6WNvw9eqDKgwk+2hPPTDcTKK7R0XgXs4uCah
 Gh30o+I3qp681lWeFe7GXbEw9vrSaqBTa8R4hHjxAP6eYNjyOdKgifga9eC9iwBM7I3O
 HT7alFyBatSJJ2XuZOtVgqmsRm7dR6lHbyucpKWzAWThHngllJKGvyLA6KGPjI/xNIuW
 R1y2CYp7iHNtSfYS2tXgK7qYQCLiXyI+8HMQyDbuue788LyC1/KbPOmMbWnj/2oxgHfj
 hSeSEZ3NyxlyPI7o8rzR/E3DW98/VmLmn9XhfFADtRCmQNt2sXhOb+OMAw3v5AlnuAT5
 PiNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Iijk42jad7QecIrUA17DOpNBceTcpzbIt4xJFBMO7hcxyz1u93erFor8bqLT/NO3/YSfOiwGLnoc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+j4r4OWWIFjxxUrfRV3noooZuq6Ut+KFVbVxuMHskAQI1Ml7Y
 MqS+vZ50bZnL6obUmVBMcH2pRz6ABWL+nx032QEBZYhL0IiRb9mEVmH2CHz3qQUIbetd9dE6oIL
 N28flq3MLWaLyHpcBPSXdgMxi/JtvotY=
X-Gm-Gg: AeBDies7kk6XWZX6KeJpcZULXkaZ5Jd43mjVMQ7N6YZL4UlGpIFwERqeHTzS85vS4O3
 NHYxFC6gLYWh7POybfzh/zH+JIfLxEgTkCsc2aCdduuJ7SOAzNE4pP+m59MhluzQkI1GAkiZaYC
 Gfn6f9yqlFITkcuoF8WghgrIinRri4TtSL37bws/qzW3PJ2OzehurYIuPmlrXDTuAaFCR6psDh3
 AXGX86BfWoAuXKrXuXomr8mX2ok08rUjXRhhmAwsoPBMewhnb76s1WsPFNrwxqMVvoaHcupiZZv
 Ge3Ds0EdDfz1uuPSl29XVHzAQSpKrLdSzxBDkZMNGQcJqc7XupZ8j7JRdY9d/ZhE+kkK24U5tDL
 Ex9nuDEA94gwfrqfqvBb3aR4n2W8rnPbT2g==
X-Received: by 2002:a05:7300:dc04:b0:2c0:c55c:156f with SMTP id
 5a478bee46e88-2f41ddff527mr617567eec.4.1777983449127; Tue, 05 May 2026
 05:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260501205825.73614-1-joelagnelf@nvidia.com>
 <20260501205825.73614-2-joelagnelf@nvidia.com>
In-Reply-To: <20260501205825.73614-2-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 5 May 2026 14:17:16 +0200
X-Gm-Features: AVHnY4IRsrOm00S5Cjdrtaixtaeoy2G18CIkU94qlj-QCX6kz6PrDy_aREt3VvQ
Message-ID: <CANiq72nW4ibDKYySiLo14B2W-PWbZv58d0a604cGQ_+A+ftBog@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] rust: sync: completion: add
 wait_for_completion_timeout()
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org
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

On Fri, May 1, 2026 at 10:58=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> +        // SAFETY: `self.as_raw()` is a pointer to a valid `struct compl=
etion`.

This is fine since it follows the other ones in the file, but we
should say why this is the case (in another series, possibly a good
first issue), rather than just asserting it.

e.g. a type invariant?

Cheers,
Miguel
