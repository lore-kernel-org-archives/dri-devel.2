Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF091FB44A9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 05:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3DC10F25D;
	Fri, 24 Apr 2026 05:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="Lm/Az7wf";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B5610F25D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:41:41 +0000 (UTC)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NH8euo2120710
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:41:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=9DPAzRc9hNFtKml/U1KgfOpti+rrtUBR6KtYeiX3hBQ=; b=Lm/Az7wf7xyF
 brokmQfLsNW68y66IP7SZ8nGC1KsXbutmXjSA8cmHA2Jk5qKrwkv66B6NLirRkP7
 QPJwKH1umKEEjOC/XCpEBPz8VR5HvrCHOhrvpKJ8eh9uddFh+K22h5l6zVDTktN7
 jLt8ikr16+iDaTHEYZBdj9EwQNQuPWk9M1lNVPnUjA9qvJyXuvqeoXu9WoHbWI9B
 L0t0VhbSUUEr2S6i4dfX70Bl57EMc2glo6cixMdYzAixPwMAfd/ptjPwyZbZODg2
 Ev/aMiLmg2rES2HuztP8JKZyiegA5AN6JmiDik/5gngMEQiS5J4atlbQWviM1YCu
 HCwba9g+jQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepavp3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:41:40 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7de44ba64e7so2609821a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777009300; cv=none;
 d=google.com; s=arc-20240605;
 b=DV/jDpKwECn1DZNBXYdiklvxJJkxSo5WgAHEc7FzLWLoI06t+jKzWcYY7YVeOlSdSL
 Bp0Uf2kDwKGyOCe43HEu3gSicrmP6X/QJqrtuAmuVv8iXdLy0vy8CsBWkJOSwoaCxSHX
 139yZmourBaWHBHnKe1dg5a/YrLwscIqnXuekumIQdGNBvb5GcnJF0jD0VPBBxi0rXi5
 XHQ+1KSHwSUUBKD/Rnhlc5RyFXVYJwvzbvCTfLws3UoH8KZ7e7jYENMHRuSHM52b53SR
 3wUMEQetdde/GnLZ06UuQRzJbVvKsVZm3f/NGcydjrP8b0zUCnd+CF3vi3ZDyJNBnlEj
 moMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=a9nQ1tVs6iATHtHJgJt0jwwPeY71kxSwK9rxJ53fqFI=;
 fh=ZGQl+DGi6Z5jswWzPVQs3At6sX3QPxgq86T+MCkkZ5s=;
 b=ErX3HEx1ra9H/XAsBlSGZvOe1V8D5VPueOK6/KyMUc7YvGSLlqIK1AMO6iehvRWqqR
 sZh3EFGA4SamYYkmgiQJVRXV3BJgSdtEgKp5VZ+DJ1HpOOSjOJgxMZSkE/9JQNRuFzDN
 fZmcexsdjrRR97ZVyALEG4udKcaW37/0LN60AfvSXhP2JE0KBBVoR8YMukUzYgbHlR5Q
 dD9gFPRvE3I8c/7J74+ZbpEyXtsyhHYC3S+1lyeLcLO5XcPEltqKQtZsotjsefHc41Mi
 PAgvN2Lc2O8FfkgO6bvrR3ZmxdWad59Dlo+dxKMbTNsT41r82jaeMG8/I4UQyewvSA4p
 rjfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777009300; x=1777614100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a9nQ1tVs6iATHtHJgJt0jwwPeY71kxSwK9rxJ53fqFI=;
 b=GZA6bwpTcd+UnTIRzf5B3LhnisHrl2V9919HHJ1P+nJTZCexU5v16oAmHC5LDsm+b3
 C0RIih5KPNH3r5/2jvC5nYPOHgUoFVFmYYpJU1wDTM+cXGJypRUsWdgRunVu4N4WuYrm
 PhIElhiML6LFAW2inpvNU5poWLHrSpBmGwq5xuAy+t7IbPMOPH4yjBVZoOombTd66QC8
 hdY/E8rRTVwLEbLXgJKgR61y4bM3ssJAQQSCxQ8Dz2NiLj3AIQ42VL9JmqqNmKMZqJn4
 PtJvQjahXzZeohdwFl1byD4409EMgh81YvIZe3rLB0lD7MnwHmaGspJCPKhkQR8CDlpT
 cWAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6HaoWPAIsuSM9Jvo+Hc1LdXKLPpODVhhTxPr5L99KDtoDqlRpY/s2EKsJU3ckhbuBBM+kNeabLHg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzW3qD2mK1JJ+PvnOCOkNpV/j7cgzrhgJ7cu/EjCVkMtcTigLb7
 BWie+psOnwbnfpeop66dSD49LcJV3Wn56DQDDt9gCb4NdDdCcJvhxhwSHYJZsMY2CYYWcGsAElg
 9hRbxgF1sFtzg0ljAMim6UEte614GKPlbrXkbETo33Er5maG+bHN8MMEspMugtD2qBx/q1OwE9l
 Po8yHjk7pPRlxNyvZyKwtwAoAsOQRJATDuZ/UXoVwfW4I=
X-Gm-Gg: AeBDietwdG+Vvv1eSI6BnvvNANs+t7P9UpMcUxjnJ7FpvjNIE3vd9biWUk/TPYnhgS1
 Ce4PNAwxrtyx5R/h4XB3Zf0FBq1gHkXrZemYl2eWCz4NsA0GtUTW4B4btkqlLLSdRMeOrXJkm3v
 ykbVKgUEifutmCeix8cF1pIH9w+Jai9+F6ZBOjl4D513TitfkflycaCmLDX0Wy7SPU6wmQCa1lP
 BOYNHGJpBsBylYJ7IwYkLkHqzJigWi0v2/EoNnBhKDOz+BVwf8=
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50c7 with SMTP id
 46e09a7af769-7dcdd585530mr8104224a34.18.1777009299937; 
 Thu, 23 Apr 2026 22:41:39 -0700 (PDT)
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50c7 with SMTP id
 46e09a7af769-7dcdd585530mr8104199a34.18.1777009299430; Thu, 23 Apr 2026
 22:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org> <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org> <20260423142828.GQ3611611@ziepe.ca>
 <20260423132016.4a25e074@shazbot.org> <20260423224626.GV3611611@ziepe.ca>
In-Reply-To: <20260423224626.GV3611611@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 23 Apr 2026 22:41:28 -0700
X-Gm-Features: AQROBzB7q1PXr8uzLTg3LU7rQ4HbjUzfZl_SYDl7pi8tYSw_JSwSgZ8wHqWD6es
Message-ID: <CAH3zFs3z5WPBygyk+ZZcDhZitj3+e3=sDsyE5ZmL2iwa=Cxykw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: siaRVoSNJYLlzOe_5eRnkaWkaxVj0d7q
X-Authority-Analysis: v=2.4 cv=N9oZ0W9B c=1 sm=1 tr=0 ts=69eb0294 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=9jRdOu3wAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-GUID: siaRVoSNJYLlzOe_5eRnkaWkaxVj0d7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA0OCBTYWx0ZWRfX/Ow4dbewNAbt
 ust2VyvBLKSfNzvntQrw4a+z8Gg0n2BqxsW9L6VyfzDXjSQjKuTQEdSYsobmHOEFX3apP9TlUmm
 NLfH0gwzoWIgytfBw49s/8q/7tmZkA3HFVFqnj0pnbUQ3K33peg4A5uJ1Q0i2gYpyirQ6YT7IZg
 pP0mUF5/gOUbZTOMt9sSuyuYUtnYqRxJXMg/fJhA0OjuZ99zl5uupW4MUKBrWLS8XdDhs3js575
 VFuQTaoQ0+nBmyk+74MBaqBD/UyY5mjPJ3HebZTnSrHHdhGpXVHHR04y5kCLPxsFJhxqceOYUPs
 aIeZj7s+CiznvwnJEl1J7++2CHarl+t1FXuGphfpolBA8zBdQXnZGOmy0WPSC0WIXnGHCjE/Ild
 y7/S3ZqiHDQYnzhR//DSjfDqlNFXPLJFGjZdi0HrKjJwHbDyR8SuLvmdaxLZa0EzQ14o9CPeUMM
 M5idDCHm0YlBmJPfleg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
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

On Thu, Apr 23, 2026 at 3:46=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Thu, Apr 23, 2026 at 01:20:16PM -0600, Alex Williamson wrote:
>
> > My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
> > unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
> > the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
> > processing hint.  It would fdget() the dmabuf fd, validate it's a
> > dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
> > find the matching vfio_pci_dma_buf via priv under memory_lock, and
> > stuff the provided TPH values into the object.  It would be left to the
> > user to sequence setting the TPH values on the dmabuf before the dmabuf
> > is consumed by the importer.
> >
> > Is that a more reasonable uAPI?  Thanks,
>
> Off hand I think it can work, with the proviso that if userspace uses
> the dmabuf before setting the tph the importer may ignore it. I don't
> think that is a problem in practice.
>
> Jason

Thanks Alex and Jason!

I agree that the separate feature sounds like a cleaner design and could av=
oid
the uAPI complications. For v2 I'll:
    - Leave VFIO_DEVICE_FEATURE_DMA_BUF unchanged,
    - Add VFIO_DEVICE_FEATURE_DMA_BUF_TPH as a SET-only feature that
      takes the dmabuf fd, steering tag, and processing hint,
    - Keep the dma_buf_ops.get_tph callback as-is.
and then the userspace sequence would become:
1. fd =3D VFIO_DEVICE_FEATURE_DMA_BUF  (create dmabuf, unchanged)
2. VFIO_DEVICE_FEATURE_DMA_BUF_TPH   (set TPH on fd)
3. pass fd to importer

Zhiping
