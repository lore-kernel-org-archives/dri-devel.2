Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C359C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BE310E429;
	Wed, 12 Aug 2026 16:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VMgs/Izz";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1709989C49
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:06:16 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4996e2575dbso72855e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 09:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786550774; cv=none;
 d=google.com; s=arc-20260327;
 b=afO5eAnCP6JsSjrMZihZBV5W0+utDrMG1meRhLXZdMAZhZptQwpSXc6W1xqv8UTtOo
 XM0CRdBpsd9NivQSYpnKq0t8MPR65CUJzwVFPCyI/pRBpHSSZPH0xFsyZYIbfs00bVhC
 NtJIZhhL0K2S2STSlCcjys7ItoDL4Sijkz1Plf4DqGwgL8IVYoaiJEmM7PV8tLQvrOuX
 febC9KMrziobbgEIRMSfEiWxPlyTIqRNXFj7Fr512HE+8wvSIsr0TfUSJ4sqkdPtP2oc
 wRR/3eJdQj3u43cqYpZJtlIL8Q1JnSC9iLKpc8BorOSaIvTzBrDMHrXQFrRxXrjvVvuJ
 juFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J9mnqO6eJ4ZveGNY3D4ObFWr3/57QctvngM8TX1zOA8=;
 fh=q3nXnP4hzQCDNzM0ODK4ypCOcvblRDOvsxGYSu3zqt0=;
 b=CCSxzHZdid+ZTPu5iFTlFUmyTQV1ZcdmBedFENX3VQUyATTg4niXH7UPrTVX+EdW86
 M/ci4eU6JAcp8EWuC3g4RV/vRVn0D/S2SfoAhnpoOsgnSOFgpD/tpB7Ulyotm4QV29PQ
 8snLS9guCYQmYrNdUR8DXMcZrPptMeXiNfzLGi6Xgidwpx4Zd9u76OXveZ/hgBPLXvE4
 DDU2C2u6SgHBbdCDPFXwZerqc0WWvnLJTaInx2in1hnqJJov1Q5F1yvijaRkRKa6LoDL
 dbvoRtIzHmUNMK0njskPs2tVqNALY0Hj6gP3s3vuP+rbpx4t6lypb6GpW0zoAu1e9L96
 Qolw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786550774; x=1787155574;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J9mnqO6eJ4ZveGNY3D4ObFWr3/57QctvngM8TX1zOA8=;
 b=VMgs/IzzuBZXOI8bZw9n/nrplZ6Dxrgd68UHWFXZDNOlv9PzwDmn7QQtPqf6e9xRL+
 xZnNPrlLo6VaC+MfE0VHMEUgqswP5+zx8GcUe68j8eoHyICflj+fW0BB0PLrqNIcF2+m
 F7lAPUUsqz1HUIqPkbhlZ4/0O9LRWByuuCGtnGgL6UsB03rpFINiKirHC83Hrqb5JyOj
 cRz+7P0LaV4/UssKyFbvAf8JnCvC6/mOhHGtf0nYdgrmQGfKN1s8g+CGXg7RqyJ7DdcH
 IgNd5iDQ1FRSbZ0VuBcxPHevIuYAKtP64XNoaNkwcaIFC2lhy3ajJbxDkkHAJ2Qb6DaI
 PobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550774; x=1787155574;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9mnqO6eJ4ZveGNY3D4ObFWr3/57QctvngM8TX1zOA8=;
 b=iesbiLO5l489dGP4aueQbs+Q3QRaeHLPY5+fHcTEkBC39SqRnqmSUu+SBPpPUVkIg4
 EFfA4FRsSNVFSRjYBt6x3Xr8JwI+xebawKzkurb2u9IFNFHUEnSrMSXWrZhoh8tFd4ek
 YmRLyOQElcRlRTjrBXpPyv/Cmcl6WnwvaN/AUPumao0QlsY9HpNtiYxT8ntTZrUifflA
 WE7KwyaE07pJUeamXxz1KTL8pGVQffCBMg4pRHo+m4r61wm8if/G11cY0k2W9jYCDeHB
 vXpY+fiU7F5aNSnDqbzsTrY9SDOOYL+IGwW+ptl+RgMjeJAfKPdtDBLx82FL+LDckT4r
 2/Xg==
X-Forwarded-Encrypted: i=1;
 AHgh+RomnK1afNRxErh+PjKdHYbkgvykpEOOUmzrHtYCyto3TvwTTSomVyfJm0GoOjh23jcvQkuwgsv259E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWTvulvjYRrWagPe1EO380jfB5GH27j9Ql0D15hoW9cYuQ9Y5t
 Jdnou/YRcVh5zsi/rXUU5L6Z0FPB+e9v/1yWgIiIqoyaZyLRrqpCV/7oj+vNFLQ3B9Nrw900LF9
 OCaLjTHb+TCywmgcE35/VcpWazpMjTHUsB88gOROg
X-Gm-Gg: AR+sD13W7PAWHtSRGpByhnlTyVRwdXh3MfLGHxulvTCmul9xJlvu2ynugkdq5LoFFH+
 C+7J9RSl/B7h/OeZDBOee0SC7jcDc4bv5JyboZceSeXzwA6+2+412EF4XsejNf29QF+XvyXF6Fa
 BvQjKQal1/TpnYU8HIGzUmNhscAY0DakKMHO40BLREGsPWMQuMys4p4Rl2TeKBjJM1ScBrVdG6T
 +9Ldbn/DwlYHtKPl84aSo7OcpAyZYQ5vEZTofsr6wr/lRANlFRD5GyBKr8InHqDUqkG/4lgpYfH
 JgEvr7CREiFQL7OnO4Dr/QsaV4vnybyzoMEVaP3iiIUpuatNNUOvI7Q04E2RuTG2DxIyaJ6Y0g9
 /RpgSWdkdhfyc6mmECgPV+5Q/PhQbcTEXvpMFGbIxng==
X-Received: by 2002:a05:600c:a192:b0:495:4593:616c with SMTP id
 5b1f17b1804b1-4997c2e7c70mr1158565e9.1.1786550773969; Wed, 12 Aug 2026
 09:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260811204123.3198370-1-tjmercier@google.com>
 <CAO_48GEUhpyeenX8Vu1NoDnvzib5FGv3rOBYNYwQEWu1-6cjaQ@mail.gmail.com>
In-Reply-To: <CAO_48GEUhpyeenX8Vu1NoDnvzib5FGv3rOBYNYwQEWu1-6cjaQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 12 Aug 2026 09:06:01 -0700
X-Gm-Features: AUfX_myIZHpwdUvC8ZYvqUsuTjt-Hphx_vEEPobdfDAGB6v3g7pueyskoXW0GVA
Message-ID: <CABdmKX0uiX=QKFAYgwwBPHW-X3vh-Rm7w-cNp9EsJzQarTzDpQ@mail.gmail.com>
Subject: Re: [PATCH] kselftests: dmabuf-heaps: Open heap device files O_RDONLY
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, christian.koenig@amd.com, shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 12, 2026 at 8:02=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro.o=
rg> wrote:
>
> Hello T J,
>
> On Wed, 12 Aug 2026 at 02:11, T.J. Mercier <tjmercier@google.com> wrote:
> >
> > Write permissions on the /dev/dma_heap/* device files are not required
> > to issue ioctls and allocate dmabufs. Applications should be opening
> > these file as O_RDONLY. The BPF dmabuf_iter selftest already does
> > this. [1]
> >
> > Users are pointing to these selftests as examples of how use dmabuf,
> > and encountering permission errors on systems where write permissions
> > are not available on /dev/dma_heap/*. Apply the principle of least
> > privilege to selftests which open dmabuf heaps by removing the write
> > access mode and using O_RDONLY for the open() instead.
>
> Thanks for the patch.
> >
> > The same is true for the vgem test using /dev/dri/card.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=3Dv7.1#n49
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

Thanks for the quick revieews John, Christian, and Sumit!
