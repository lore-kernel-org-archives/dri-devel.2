Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA19CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276B910E2D6;
	Thu, 28 May 2026 05:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="bg3I3NDv";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A8F10E2D6
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:35:22 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKlcsD3164600
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=4PCAVqJEOIY16WjmmTqer3R+L0JDJr0Ts1ek/LWm3fc=; b=bg3I3NDvy6FE
 iPpy9G16MrgkS7tjdaK4pTBSzqZEYYkSr5lSf8zBn87x/6ztIBfNAOzJnXbkITnP
 VFaM/GIefnYWYt6TOhjePYUTwpWHC8tb9G94iars8MRPC0B3+3Bv1ehGIH2uF3r9
 X+cCM1mir88Ht7erbVTrSkMQLajLsqaX4Ka+CzlrYNI/+3xJEgpfsUb0R2FOT8oP
 C+oZphQuk8kWYB+GKsZEiR3QK1YcNTIkHoPt45gLIQZGmdCOi/qzknAC5w6RIfgQ
 ucUNMGl3JC8eLuPUn4MPOudkHIaVMon2NrKpJ0qR7sanUhqV/uTqc+2Jx6QeO705
 BV/ccfW4zw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7y42b5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e666c30bdeso2511876a34.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779946521; cv=none;
 d=google.com; s=arc-20240605;
 b=kFksD1gPTLtO4ze4aScO34UMGlHunNtBTOq+wqCab4pWrZ7N80LQ33jEZsMP4qhsa3
 iZTBCLj8BnfxBg3S8clKqYzo+dvV24avbz8Vec6QFmKkq68ZuqjuL/KHNarEVuZ44mz0
 7/0Fjrnfg/Yh4BdRe5wgq5Esn5PecJEwbumKEUY6k/RXE11uba6+ZLYPFTJN7TWInp3g
 7hcF0I+O8mUbFloQkEYOl11M3wAS8aFYB48vxLcgQWBvlMAGEvfP1Ic3fWEs83pB8sCn
 o8+w4ZoAxE6WiYrs9l9YJwWA+GLXRhEoyNeCeZ/whVIyHftVk41nmdFzqkqZmd/r8Jwk
 /uHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
 fh=NdkPMVWLQ6FpP3AaofvIskPy0uHiWEFzsWpbX5mVZJ8=;
 b=cybxQhSpFcD8m6tl9mm499YAtpVa81BmVUmra+0psPHN7iq4NO/1r4ptqY/i24Hscj
 YRnl6A/GOXAqLnvbo907DKKxnh9G5bXxxH33h85Lc03MUZwJSy2MIKaPaMktrvBqBcsG
 Q83OOrNtOPuvc1oQJILiXNf2CyWMra4sJuN98kW3nwoXm4gcvdMwnE5T3GV+idDoPUQk
 iLGWmkUt8zYv8fqzT8G7ttK5EPtFQiEBW4eS13fmqZdYiAymZxiy2BUicHI1j7DRo9OW
 tbMT1jOoNPgbVtL9sCkXdkEqsKVsZ+jPGAnze5Ldj5s+i8FJ5HmzezOvtOjKzqvkDabA
 gSBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779946521; x=1780551321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
 b=XyDwb3GJn0Z4DlTVsTjKgfgsKEldvBkifutcf779PU3okXKq83OkLrXAE/73o9txEP
 EU8Ug2D2L2Es56QhmTWo7WQ72AXjbYWL8LdjuNsqJOEHp/n2vNrHKEAA7+N3kHLTwXsG
 CKCaCmBC4ysz0z3hvbYEtSjPF1AesiBu68cW0HwM4mvH839sPYQ7jaaOXYlsFWm38ayE
 sxzJepm2vW9UX/8PS5wF1NSISQzI24vSuMaI/iLHqmbbgXT8VuGwILHetDalMR2xiTbc
 4Cwr2y3WPB0Mkg5uy87uzUup5I51AYGz8yGGjdo9c+ldwu7KeeyyYRmE1usJjsKpiqGg
 CCYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9n+2291bEX3ad38JxGECKEgnj1lGLQGl2SbRJnHmA0KLgyhEPMAnZXP8cbieocYE1KkaEV7P/K4ow=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcFlsN13PI9bQgp6wKTfEJlYSHicKSeg1RSchEvg1TeJlanfzn
 lexzT+zpbKEbhLSPSciddqYa0+5apWdJnO6N+A7d6rhaBjxohFpFPeeolRekZLHAv5FLVGPOgFg
 BSdHLCJCjslJzpY3hsQ0xDqWuJyzIPnY1YEznJCfxRJTJISgvqiLTXcdy4KQCzZCc4kzEVa4y6R
 Omci56ps0K7bF6x29PGXVyA0ucEHpuOGpaK3Wt95Z+04c=
X-Gm-Gg: Acq92OFt+2i1t34V0AqlmlP4c1dv2UdCl4Z8gOXYK+sUJmj0Ish9gv4UJfZS/NbZPDc
 ViMde8+jReWjfu3xkQI7UvQUoVOW6Fd2XG2UDuxsAMxMMoUS2rCfDCRjNAWaa0stOCkZgIsQAoj
 XRz7ZMYD1PqXmXeyB4CCuvG58tvG37X05ApBl7VDACwv2JJvX8wrl2ICGN5/hYvvQn1feqgHlWs
 CJPpxGrVTz5BpoN6GLCU/5waNddBuxTCLuQ77UFJw0hMBmIQds=
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id
 46e09a7af769-7e5feeada60mr15174374a34.6.1779946521032; 
 Wed, 27 May 2026 22:35:21 -0700 (PDT)
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id
 46e09a7af769-7e5feeada60mr15174366a34.6.1779946520637; Wed, 27 May 2026
 22:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org>
In-Reply-To: <20260527145332.30412ea4@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 22:35:09 -0700
X-Gm-Features: AVHnY4KV2jkBImuet_2z0_HzyoNlAKuwWC1jyQGu9hjYNIH-m9ItRdizP-UfkeA
Message-ID: <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Q0eA1Q_M6FStnjJ0VbWAg8rzlMKCss9R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1MyBTYWx0ZWRfX9+LTwGQgN0ie
 JiUH1xcHKu52aXhlqDWJsjW0+din2R2/Io4zZaT9536dzmUhZbX2wjWMEiSJhTC0shOFtzj6qbu
 a6rVDLXY6Ouy7ESkfRd0ESb9zUK/BIt+iEXzD7/FIY4pLB68L2p930HDQzkYIRBsVsJ6Nf1ptxr
 w17UKJb94bKC2e14rIOQJm4FxSrlxocSqpAXxVirvVc5Pvs/6mbEvOBUU0HbIcL2ygddUJTHUcZ
 ZoBxzH+4y5nTIiMBRvFUb7DN/saI6cm9ytdyBjMELZQoDf796ltP1usVUxKVx+fnuSQEKXEN7GE
 vLM8E/1UY7C4yjPL80fhFcrG8s2s45zFlr5qvUgrqQ1/dRGdklKg9hX/BasMHfwHsBhS0C7I8Qs
 uiyVyaOitlZMbspBqnwmMeT7Gq3sSnmB3geYRxDDFRDMV/FQeNPpKsTiTIbWofPb6vpSzEErst+
 vBZaOeHRiuxpAzhdyTg==
X-Authority-Analysis: v=2.4 cv=Xci5Co55 c=1 sm=1 tr=0 ts=6a17d41a cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=Yn1Yo9TDUEbBsc1NC8sA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Q0eA1Q_M6FStnjJ0VbWAg8rzlMKCss9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
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

On Wed, May 27, 2026 at 1:53=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Tue, 26 May 2026 07:43:53 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
> > !CONFIG_PCIE_TPH stub for callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/pci/tph.c       | 12 ++++++++++++
> >  include/linux/pci-tph.h |  2 ++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 91145e8d9d95..6c4492075ae9 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> >  }
> >  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> >
> > +/**
> > + * pcie_tph_enabled_req_type - Return the device's enabled TPH request=
er type
> > + * @pdev: PCI device to query
> > + *
> > + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EX=
T_TPH.
> > + */
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> > +{
> > +     return pdev->tph_req_type;
> > +}
> > +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> > +
> >  /*
> >   * Return the size of ST table. If ST table is not in TPH Requester Ex=
tended
> >   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> > diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> > index be68cd17f2f8..fe572737b409 100644
> > --- a/include/linux/pci-tph.h
> > +++ b/include/linux/pci-tph.h
> > @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
> >  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> >  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> >  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> >  #else
> >  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> >                                       unsigned int index, u16 tag)
> > @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev =
*dev,
> >  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
> >  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >  { return -EINVAL; }
> > +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { ret=
urn 0; }
>
> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,
>
> Alex
>
ack, will do.

Thanks,
Zhiping
