Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058F8FEC118
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B5C10E0FD;
	Tue, 24 Mar 2026 20:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QoO/OfuI";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8542510E0FD
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 20:52:07 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-89a06bc2f1bso64700966d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774385526; cv=none;
 d=google.com; s=arc-20240605;
 b=hjgpxuHWqmFkbxBFFJypgc3kREbm9lZYITG8GP23WvfCo8l9I/mqH274DqNGa8zrHK
 NDmGcDd6cgUbWn4/+SVGFVhtcoyPaGUdI/Nw8Oom+HM9Sot00LBEvBhEkEpCNkvZ6Rn6
 rELynyShDhwtaUNJM/o3x9uo0r3Ya3RU/XQ1WOOftiHJH4uPsBWJp+Z3vUF4KTmN0Rga
 T+jAzsRsg6rlM+U7cxg0Y9n1ni0mZU4eCJ34rbRSfno2Jk+HgiGm9xw48naI27f1aDWe
 FI2ahkEhpCg/vY3G7UByMD2CniABBUbjgqbcuwvFj5QMGIOHm/G4ziONVUWVM/Xff1wW
 XcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jAmbrBaZ26OrHak3Dbvj31rxx26EmJg6nozGkFXA00Q=;
 fh=rgirIlVehQlFg0WnIDzIuC2DiGCWsiB/G80wmWxn7tw=;
 b=Oz2oKW/cI9BFaG/0mLEDti72XIqbtS4C41oNsnK8YGQ+a+0u2pWlXWYGONyW2M8lt0
 rpqYcogUe/x8lIHIIbrv+O+umM4OYdNTJA3GfBdVm5R/iOEgHwzqJknwAj8TuOIHIkfy
 RXgwpRO1FMw5p+A4l5DhmuSl/J+QRD5QVtLCemmw6C98Vggcq8lj27z9DENv4W4gb+Y+
 B+oTQ2lzwcti4Roal/OaljAt1u8HTaao7dg5mba3mZzdQCIahJNorRfcYBHZeOYo9v2j
 Y7AoudVmIpoS9KpEdT6DzmEuI9T+MvPW09WnviH44XazBqdnWtuZ2toRYGYR8IJwUien
 uaHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774385526; x=1774990326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAmbrBaZ26OrHak3Dbvj31rxx26EmJg6nozGkFXA00Q=;
 b=QoO/OfuIwlshW7stBei3GQEgK/rnh8bfN7zbJYrfkWoz9Ai8jn3elf18VuzZDXV633
 OeyiCO7vm8+MSWPlqkF4WskGX+1U+C4iOh4VjkQJfTJBzyuEzY36zKYz8hmuCDKcRWK1
 pFriTqTmdJBU5QWSIkAppcv950vWRUPChcg8le9+dnhkEC8x3UQBElJlqcU8afolS3Md
 nQAckkwLFI4mB4bJueDlPphhhHeJCPwWY7s3pagUzhKceiL2zQsM/VBwe8YmKiZIXlsV
 BxxhYJ6mEwcgCoiVNiLgb+3FaCGNSUjWcy+L7jrXqO6ST3GsFv15ntCTLLviU91HZa87
 QZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774385526; x=1774990326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jAmbrBaZ26OrHak3Dbvj31rxx26EmJg6nozGkFXA00Q=;
 b=lDvXOx5wZpvY/IDNr/nHvGIG99O3gzq//Qz2GTKyNF/6Ghl2q6gnC+I2oJvA9IaAXh
 CCMVc41xtbCP4HaXW6vjEzlfyA/BW8y4mVok8jYvGRJ+UqoxX7jHwDk4QVmKlQD8pjWa
 ijPgYgJu5hBKkRdXxWr5+J+Q6KK/T9b23AME4o91OdxDZnoP2K/uYL5nP9/KKdmRp2NC
 6nsdu0lNIObg5BbOkxkIeMJyXmlZ6iTii0hvrf4b6uMFzeFxXdGcfxn5EcSoD9VFFRmS
 dEAt5mS2EN9cX/1cbmNUxygEl0whgy+B2uETPpjlS1Khe2XTgbyhFFbnxkNYY+7xrj0i
 T44w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH+gSB9vDVINxf6mfp1yPd9rzlMN08ELlDJ8HyNwhAIYmANxckIrhg5HHz82KIMb4QA0TsENoNk5g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc74RSzyq3RO+iGuKBQh9bBh8HvyzfWdrI48Ui12baEWm+/OM5
 FyQyKjQ9KI0TfrNXYDN2bw+MyKQ0SWSizMpNJKBn0DBT4df7Kw0CrNOqc2cRd4ccyOuiJx/C3fA
 FPl04ZH0ugp5NsZgqqlmjWP3LoxYPbhs=
X-Gm-Gg: ATEYQzxY6zlL/r2xfxriLuMm1QsHak2irXJhkSxrOLyvGXMuwsmKNyTBWWichlXmu6t
 loJiUJjjsGTguF9ZlFjQrQh7s8Kjf6IqFxjAGBAyBLydQs1uixFUI/9Bsw6+ZEgXHhMx87KJnYJ
 QqDBxa3YyLlcCNeSBLHiNHgEIc8MV8njL/0vcuXfKabkqnups15k4IbbQf7xm1IyNULkpqi0Xzc
 RyK0HEWFV/RhsYBE200KLtmCCIntuDm5DMdBV/wdC1TVga3kPuMfUPfyPEqYokc7s+zlJKQiE5H
 BCg1y8cf/FsHDXUG7XnBnjdaCpJamcCtviFLbw8T080tOvgj7Ig76U/V9wIj+cM5ats=
X-Received: by 2002:a05:6214:5d84:b0:89a:126a:5b76 with SMTP id
 6a1803df08f44-89cc4987cc8mr20366566d6.13.1774385526402; Tue, 24 Mar 2026
 13:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
In-Reply-To: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 25 Mar 2026 06:51:55 +1000
X-Gm-Features: AQROBzBinlU5YNprLAPZjiZTEcRGC-eFchvVyb4GHvI0tNDoijXLfdD2nznshI4
Message-ID: <CAPM=9ty41ehnPCuiwHJGtRsnrdoOL0w=hpxnA_Fi3YDo+=6dfA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Support repeated mappings in GPUVM and Panthor
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Janne Grunau <j@jannau.net>, kernel@collabora.com
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

On Sat, 14 Mar 2026 at 01:19, Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
>
> This patch series adds OP_MAP_REPEAT flag, which lets the user map a BO
> region over an address range repeatedly with just one map operation.
>
> Sparse resources in the Vulkan API let the user leave regions of a
> resource unmapped (from the API perspective.) Accesses to such regions
> must not result in program termination, but loads produce undefined
> values.
>
> To implement this feature on Mali hardware, Vulkan sparse unmap is
> implemented by mapping the specified region to a "dummy bo" so that the
> accesses do not fault. A newly created sparse resource starts off
> unmapped, and therefore also has to be mapped to the "dummy bo".  This
> "dummy bo" is small (a page size) in comparison to the sizes of va
> ranges that we might want to map to it, and a large number of vm_bind
> ops can be necessary. For example, if the user were to create a
> 100e6-byte sparse resident resource, we'd have to poke VM_BIND with
> ceil(100e6/0x1000)=3D24415 map operations.

So other drivers pass a NULL (xe) operation to their VM BIND which
then goes into the kernel and is handled in the backend to write the
special sparse PT entry.

Can't you just do the same thing in the driver backend, have a dummy
bo allocated in the kernel and map the pages to it when you see a NULL
mapping,

or does this mess up some accounting or refcounts?

Dave.
