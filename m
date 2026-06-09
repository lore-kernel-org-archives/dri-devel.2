Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2633CD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C41810E3A6;
	Tue,  9 Jun 2026 14:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="b+bzFh5l";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9914310E41D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:38:21 +0000 (UTC)
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659BNWQs2242310
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 07:38:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=s2048-2025-q2; bh=A9sFQHsXqHrMgAiwxXHw
 qbtJi56QK9Hsrm8AczETl1g=; b=b+bzFh5lZdFG6ZMxUJUlD8Yt1iTFLbUkN44J
 0sEYOv5io+R4jUYJbE8CO/8bzyHasyD/fqldbu1TQANBQ68ej/P1D7bCh0Be/t9t
 77ignPYiVT73nQeplrY12DpT/Cb+rEjERmUU6TVCa6V7eUZ7JLMt94G73fGvajze
 zyUZleQxuZvCbUUSXYPL/gojMV01wKZCDt1r9+IxqZGQ1f29Qp3i37UJwt+6Vg4s
 mCO5U7LHFg4UrHlCu+BS9DH360ffxI9Csawy+GcEYer3nQpVrv42nRoVOUC7IsxZ
 e7IvZ+NUUzgTwRET8EbK90UUlwI9PBNVSniNuv50nJRdR5rglQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en5a5ne15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:38:21 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e6f45ce9ceso7595307a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015900; cv=none;
 d=google.com; s=arc-20240605;
 b=CKJo2gS6jWeR6k9AK3Y2Roi3jzYyb2HKJdj8ddjKZpkgiLNJEhsYmzd/2Up6iJgMc+
 vN0S+9UVJyYd5d8FaV3WK+MRrZSm8Y/GddooezoKYr62907yLaOqsEAm/oKfH03yOCZq
 4zPsaRdULqFDpGuJmEVqvy844nPaK0jAZp+DUHbtTCfztbfc5Mhzl0JIwfaO1I2TdAaU
 bsZm2PoTxMLg5v2pWBS04L57pyFkMyizWsJAeJymCX5rflNMSnukXP19lHCAZTedrilz
 9BMnMVJkSQWqNI91mIJg/VwBFDzKfAirdv3wPViiCGKiXBPcQzDeYRLXoxI0nPkFFnsF
 edzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=A9sFQHsXqHrMgAiwxXHwqbtJi56QK9Hsrm8AczETl1g=;
 fh=j4fiY3RT3ae0w9YMhNc4KmvCLSiG0SqHyK7rknRZUwk=;
 b=eJOqXF2j5fiKmqPu2FUC9N2MLE3ao8bFyayTlFMZYmmKWIjkSQnlLPHi+Ha9IwyVL1
 zEXWLhCJ8WyMUXBs3/iw2LwVG+yN0XaB+p1nu0+IaWBrw4MiVBsHbEl0OO5U9DykObHr
 Z3VC6ydTJX9tK40/1XV9OQl3zfZhW08I+Iug+/SqfruRS1n6gw/BOE/gT09kXcMfMR5b
 IBxDF3wvi2fKF1RMH0MNKdKsblImTL+g0J+i8+7TLYlc+blOEkQIhz2mq0wDC1JaIU0F
 GwCeDp9rBDBY7m1RbOYOFnb5OJhEyRe4/vGw/MD8bw1swJbwU5yel1Wp2EIsvstpbQKG
 ztQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015900; x=1781620700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9sFQHsXqHrMgAiwxXHwqbtJi56QK9Hsrm8AczETl1g=;
 b=PpWaGU+LkrB9rnZ30XfULBsjlDXrpDFj9Jz3yGAEvItHJJPaQPjbuTNPiG9Zq1MoLF
 hrvgLjc03MZ2eu3fqFebh9s6nCpCnXt2YWluHyot/1pFYSZ6LdFj59SRU7SkIK5tZZdI
 IhkeoC/VZlpU5M4t+k+A42y7lijHGLhlzvQPFPVc2+qWeUW8gEXMfYBg9nX9hjvvr6pU
 qIi8DMnhCtJ7Oxy23UhujSV49GVJ12sy7gVqltokqbU1R6InIzkwRXGjT1jK5noFAsdl
 JL8DZicXqp/7rfshLoY97P1U3E6GO7TRVblKclr6rEOjMRG1rO4f3BrGIDmZSVERmbCx
 cXfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6YwJ/8or1NlBrK1dEe2ol9VVXSGPufkNdSsKktOKYLBNWk1vUw9hlCncp16ZBDni6fLweg0rHzWc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdCyLIEiY+cmMfjE/a0dNZywQfh8ljf4pQ7WBajAaqaOQIFXQp
 jbTo0KVU05X32U+U9fVQG1Sf4FSEQQj7EWveDELAKY+NQtEopzuoIwA/C0Vj4As5o+gNuFES+zv
 DQrvRXGue3XmxBCUWJM4a5KUl4GI+aBA5YVe62RUbClMRW9dRA/Y6hI6Chd1EHFq31Odmp3XlPR
 LHslvl+7KTL0E6KFRU+vvjpgnE4E32V3ENLnWhFPd86c4=
X-Gm-Gg: Acq92OHPW4zSN5Hc5+ZhEQFVh/jt7Gbr6I6h99DOwZoKXILbZqQXv+nKimhDwtc9V2l
 bNJlqPrJCtQCqpQTDDxKgqiqa8WeT82KyWWXB76N7PFpNplbc4WqXk3YwMoUNW81gB8XT+kTm4v
 H/orrarz0HhcA3tGa0Uhxt9Cguz4V0J9uuqA5y8r+zA4ajJvegqDQo5rIfPnYcomG5kQ9laZtwP
 IJxRMGMj7w3GTc/zVIFDjAEsESj1YbcRsTyU7OeKmBIpRptNPQ=
X-Received: by 2002:a05:6830:6a96:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7e70ca51cc9mr13515119a34.21.1781015900244; 
 Tue, 09 Jun 2026 07:38:20 -0700 (PDT)
X-Received: by 2002:a05:6830:6a96:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7e70ca51cc9mr13515095a34.21.1781015899753; Tue, 09 Jun 2026
 07:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com>
 <20260608185646.4085127-4-zhipingz@meta.com>
 <40243782-e4ff-435c-ae40-3ac1c7c4815e@amd.com>
In-Reply-To: <40243782-e4ff-435c-ae40-3ac1c7c4815e@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 07:38:07 -0700
X-Gm-Features: AVVi8CfGCq2wYUK9zUjDs8_E_dqHl5wHKtBE7B2eSNCP9pHNCaJrScoAmctUT8I
Message-ID: <CAH3zFs1eE2VrxOZA9FoowJ9AKeBkdZE5P6t1cH0bxXq0iY6AhA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] dma-buf: add optional get_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: abYDaK2ljn54yvOcjFAD42jGAWn-epQC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzOSBTYWx0ZWRfX/pBmguHki3KQ
 Nlf7x7bWvO7rdCf0JwDU/O88BLFiQS5wzEupSqrnH2ZArEVtmpbeGUP0SiLXinzp2T50W1qNJFi
 jxbK9AdGXuIA4Dii9wbF0JJvW/MTCmOVNBVRXHVhtVg55awXinnUG01gRZLfwS5sp3nR3TL2GqE
 Mju4qXCcuedoQ0GUqd8mHzpVJ14wkf7uG2HBhr8zPXQv3/C4HJTUtv+VCveJRmhp2oIOIly9DC0
 775UxyMzwPRC9GSBdam5rmqg8Ti0gAXS2e7oS2ekC3lrdvERGYxljyvkfyY8o/6Rziqii5SndUa
 xew1IVTgvSmGs3+TUkYFHLd4ytXSZsAZRVxrhOD+vTvNcapzTj20FBPHUaJ7CCCXKBwJJTWa4ry
 qBrwjteiWEN10Zqcx6XpSsDlWx0wzOY9hykOL9gJ4TLakWVELMvprYaEClkyGcidM5qIAakqIGc
 j7tpFEIbPesJo0WXRwg==
X-Proofpoint-GUID: abYDaK2ljn54yvOcjFAD42jGAWn-epQC
X-Authority-Analysis: v=2.4 cv=ZKLnX37b c=1 sm=1 tr=0 ts=6a28255d cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=KaHoPmoT-FsTecDK8CMA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
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

> >  include/linux/dma-buf.h | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..8437dbe4a83e 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,37 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @extended: false to request the 8-bit ST namespace, true to request
> > +      *            the 16-bit Extended ST namespace
> > +      * @steering_tag: Returns the raw TPH steering tag for the requested
> > +      *                namespace
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with this
> > +      * DMA buffer for the requested steering-tag namespace. 8-bit ST and
> > +      * 16-bit Extended ST are distinct namespaces in the PCIe TPH ST table
> > +      * and may both be present with different values, so the exporter must
> > +      * select the value that matches @extended and must not substitute one
> > +      * for the other.
> > +      *
> > +      * The exporter owns the completing address space for @dmabuf and
> > +      * therefore decides whether it can derive meaningful TPH metadata for
> > +      * that completer. The dma-buf core treats the returned ST/PH tuple as
> > +      * opaque transport metadata; importers that support TPH place it on
> > +      * outbound TLPs, while exporters that cannot derive a useful tuple
> > +      * simply return -EOPNOTSUPP.
> > +      *
> > +      * Return 0 on success, or -EOPNOTSUPP if no metadata is available for
> > +      * the requested namespace.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, bool extended,
> > +                    u16 *steering_tag, u8 *ph);
> > +
>
> That needs a wrapper for importers to call which also handles if the callback isn't present.
>
> Regards,
> Christian.
>
agreed, will use a wrapper in next revision.

Thanks,
Zhiping
