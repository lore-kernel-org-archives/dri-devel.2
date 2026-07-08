Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98358C44503
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020F210E612;
	Wed,  8 Jul 2026 15:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cqdCEcXo";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62AF10E612
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:25:30 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-39c699b2400so1224241fa.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524329; cv=none;
 d=google.com; s=arc-20260327;
 b=fqVaCrwzj7zRu3NwF6WvH84NtYgYqWsl16tt7Lo1eBu8nyIuSlC/erwoTeAazXlVs4
 hMNAjZfW7YiO4YJAiEUavXmfa5Ag1bxdqHwrZyOjuBwGzRYX5FRFWmOPmeglLRzFMN4Q
 /ZnmRW7eOFlIWliDuvxR/wwOyDNmhU7CXhGGgVq34dQVH15qy4dY2W09s4oN+PO5FDNJ
 P9f7Z/raGtLS0ypjwO5SVRQGHwix7z7geJ4fAJH78/oPwAaRZ5VquxFwpr702lGfLz/4
 8wqXSKcMjlzngxbWs/0AD4UrgLS8nwHtuGGoTNMAyLbmh7iaL8+TlQqhB/aSvpOFz91K
 qSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
 fh=WOCIc1kPLtUT/NsuUQ2/pyiUj+Y/2/rV8Kp1WdhhLEI=;
 b=UGI/IWebbmrT80ZBkpwo2wDJFBlbYuq/PIfNiai2jJ4T/WBFhwjSmtqgkSnC3Mu4ea
 JNnBDh+in+U2PCd2FhmCRBMh6fP1pt1430k3PyP/W+GV29c4rt8tAWugFkCT0xNTCb7a
 33oe67mUZEX20QvUI7qrn8CybsKSNhvlsbj0GrcfLOEjY7m63p2NHEaOZ6G4YxSkhrm3
 0UGrweDTpt4JJzVdRaZZxs+Qg+UntPD2YZ07JeKdRQQIyic7lg7TIPjmN7Kkzo/t3uk7
 JB04/SsBwHhfUZLLipNvnNsCv2+D+LgyJFiJCtLfNyrg7IwXAw9CbAdA45sRwROo/RVu
 p5Ug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783524329; x=1784129129; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
 b=cqdCEcXo6wl/17kJMtBe1zfvVZAKi7FMA3tSfflTkUvoSHwnaIAJWH2LGCinj3gB+T
 /sewK72p2AL8F6QYflGe2hBCstN/oRCh7LEH3kGQtqy8uVbKAoeOTrT+As0v3jkO7LOa
 /6sq8YkynIpQsSuSi9KUPFNTuULN772lYA/hr7uUiVzLAbA7AJXzhNpI/1aa+7ChS0vV
 1RuXnbavO4/x5XZhV1CUNKFIa8QFJuMJxsGJdodCikJ5tnUDVVNulX3lOwkZDMEu4scx
 YTmAbRTUIgyhk3RJhOSE15j90kK8GuA1V58f4seGFV+sO03KKi0SAxdvAjSdkyW8PJdv
 nKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524329; x=1784129129;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
 b=eAuThEQOkgSBWji3jN9dLcKLM9iAt+B/JjK0sOGlcKyzZ5VuvKJ+WMofglCO+0mkIk
 Jfb5I6s5hNomYhfwH5jTUb1UZh1QY0FuRlWY+tIDtWbft4UR75tchdL2yc12AUeVeh2D
 UsUpyq1XAcnfjAIUpe01lEDqv2JixTUDmpdGiISOKTx5BnNX5UzrSCVGynIjlxRLRJ96
 NAx+ZVzPZeDqlUVma/D4qi+0IcA2G8TMV4HJhSvljGfFKSD4szgcLab+w+DkJg8tuzYe
 fGxnv4j5vIR2st7u1OjaorCcVjQsQuG9bl1szdosSlxwzDXoPQiLw6iZSkSF+d2+wUZB
 ArhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqEbz2+rnJrN7cckJAJwVZ7p2xk9J3jtOPxd48m+gn7PL+Yu78QgrTvT6NVLKyFdQISJacIjAt87E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeGT7dU/VrGa4UBvUvWRP09sy6Ebmi0QD21pfcZCcMVicoN4vL
 kfOmPizJe9ZBt+aVNDzNd5nTYgBmSHagwY1Ybru0piGHG96d/tPfmw0YClG2Rx5axjH/MUXw2ev
 f/xe0frkC3+IddJrAJBjhNTauY62FsUg=
X-Gm-Gg: AfdE7ckMW5gXZM3YE3DZdl54HQ7WCHXymYtqu5cDWErOGqGXfbaOPOKhxY1JF2/tvfN
 PTIW+viOCfcpHXVlspWQUXOQzkq9WAuAujvFfWXrEzwu/a+2lkBhdFVkeP/Oz97WWnVMgItCRDx
 ADb+nPsxeqs7HN7JJ0+mRoD8UO4AFqmslm/CjiMECy0ydecFNxPQfc7YuZkOB2ZnZn3IQ+qXbnA
 9/nu1nqAXeNec57Xw238bvpygo4lfeYodv0Bdv2uG9fwOftLSEk/X4fxaPFic4GexwtKuM6kH8D
 yBNDoWD+M5jMldJskhkcGDYzmHQ7TEpkBEXEwokwsv4hFg0KQyi96THSSKWvbFUAQrGmOZK8n8b
 LY6jRPGSPwCgI
X-Received: by 2002:a05:6512:3987:b0:5ae:b9b3:9f96 with SMTP id
 2adb3069b0e04-5b0115c01f7mr445459e87.6.1783524328462; Wed, 08 Jul 2026
 08:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-9-72cd5d055d54@garyguo.net>
 <280FBE45-5653-499B-9BB0-A2C77030A826@collabora.com>
In-Reply-To: <280FBE45-5653-499B-9BB0-A2C77030A826@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jul 2026 17:25:11 +0200
X-Gm-Features: AUfX_my_GxC4KLJmz5i_4DX9QExeJawd6XQyKpw76D3pBDNdQQvLPjQ9qPUqEYs
Message-ID: <CANiq72nyEK7cMphaawV73bN7VmAKG-UOE4SPDWDpAqoLs8zzKQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/20] rust: io: use view types instead of addresses
 for `Io`
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
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

On Wed, Jul 8, 2026 at 4:37=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> You mean to avoid that cryptic =E2=80=9Crust_build_error=E2=80=9D when th=
e assertion fails?

My reading is that it avoids the assertion failure itself -- if the
compiler decided not to inline, then it would fail to build when it
should have succeeded.

i.e. it is not about improving the error message, but about avoiding
the error to begin with (not sure which one you meant of the two,
though).

Cheers,
Miguel
