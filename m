Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C56C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 23:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C06710E1A7;
	Tue, 15 Sep 2026 23:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="P7LdrCN5";
	dkim-atps=neutral
X-Greylist: delayed 372 seconds by postgrey-1.36 at gabe;
 Tue, 15 Sep 2026 23:34:00 UTC
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E7D10E1A7
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 23:34:00 +0000 (UTC)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68FMP3xV459343
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:27:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=puTYzaznhw4+fIfX1uaMmGMJC1CZW9OyuJIqa
 VoOjFA=; b=P7LdrCN5RlHrQAwR3lh1Sw42HEUBPv6LyCl+r8hwB62t5uwriMQbD
 rm3NHwvD0PaefgR6OLHyroy5wHF4NVm+G4W63yP3NyZYHZWKoV3mbJ6JwD/WzgDa
 RCeXKORnF3xngXyoH0nHuBfJCW8zHXhDCn33h+JKiHawytHEapppS8dI22J6V2E6
 w+wP3sWCpYGwv46N0moEuenEzZJXV3cz3DJ4nWBpzrkR/rAXp/InbRpHQnm4a4Mq
 Krw1zm+PNYoHvCoper3L8ztW3x3PaHAyJrFmTd5OAYW7ZeVhs4ef8tPXRuwdBjYQ
 kousKyfTwk1c3s9n+5u7EB3H7XOriOxrw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by m0001303.ppops.net (PPS) with ESMTPS id 4gq0vdefmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:27:47 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-8056a93e0e3so6885781a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789514866; cv=none;
 d=google.com; s=arc-20260327;
 b=K73SG4FhyTYubD4y+mVYnbWyvD0ArrqzkKYzrJt8VVgrdFIC58uZs7L8Yb37D2uD7T
 rLq0wwADIV+HwAkwB9t1zVL0k817TU9cmi2O6UYQUmVcBNN8YkJbnpvgpYtFiz8286Pw
 bNfGON1fJgEW2Ee5iH6y1tSOXLfrEba0+ktsg65Kz+P6ZyZ5YHkLopBU03ESEI3EdL7B
 ip/drq41t/qFTJ1XZRU0JhI+uZnnPcebB0sZgjQHv9KAIEZPlb4jD8lnJS7GwxTNd9vO
 GAtcDy7E2BhlenWaSZ6yP3K4bwE7DOvdKFEQue3INMqgy3MLv0KD+Ppvcj5gBdXpVekk
 14Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=SJKC0cK2PwsxosA12SybEYsbNkrOGaDMLHL+9hzWLps=;
 fh=HVwLeXW1FFxWxqRGonrgBQl6or4ZAER/cPtvf6K2QLE=;
 b=Tiz463Fsl0LDQwBd1ZRDINxDVq6zTp/dx/+n4hdD24E/dMytZzuCYDI29vXtxgCtUZ
 WIaiHMdXtGOpUYdQzv6PE96uM661XLNKb7amwO8ukRmoEVE0UMRvRpboIll3X4Oq3OED
 n3qMbUIHptCzwjzAyLU4PmbaQbVP9Dk25zCzMpJ+055Y/sm796tflg5DSrd9+hdQwMAY
 k1DHER2MpKY9tlGlzBsJnTzKtKOv1iPrtf3EnlprusrepBZhPyrIxA3spfNQKmQQ2zbn
 keWzreEE36XC1zPWWryMeiXt2eSQBTMYlXwqjWQsAfghsuCcJqN6C8g+8dMHkzqyP+0R
 b6cA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789514866; x=1790119666;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SJKC0cK2PwsxosA12SybEYsbNkrOGaDMLHL+9hzWLps=;
 b=I4F5ShWdIa3yFa824nx3ZAz9CSvPPioG9i91bn1CcC6nn56coPLLvhGX5ndqkYptkT
 Tyn45wE0/WMk5S/3z8PMNMfFa4AOAV/f4uruh4I7QnqX4SF6rsuv27HZ1NaAE5HetcGF
 gb5+qTIdV0Gin2najwILDgWu4z9W3XspBJ40yDGJu//r7UkQkPEyiaAcLYVlvO70S8GN
 moSURU+DRzmMgmzHm1qkvpeyXrR68/XK4MZGuBGcQvVG1Fu+oxfI+ojCKMSNzMlwiCIT
 QaokEFvV6aI+Qch6y5yPshqfQgKvScty6WYHYWI8hYifjcobOrq1jRg+mO6PR1iynZAV
 3vwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF6xufY/0CRmNA0eqhp/F36Jykl7lFd1Nojkw4rk3mvR5veFyn8SZqYDeW9ef/Yd5lCn0SMpY7vVI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKN19iagw5IwiNWULSbOcQZeoKtMZcLYizNv9KN+fpilmowDWd
 HUqHsYRNQAapRVkAAqVChEDZHyPmZDurvI6TRZlC5v98hYkxAf3X/9VHdoQ18FA5t2jRp6ymSO3
 b7+RKYz3O897cPvf2WLXsDa2hPgYz7bF/dJsevH/2qcnwwTACt1svZCDWlgQaq1vkHKbTBM3T/G
 HxyT+DrmUyUkMtYWmRixFaoHrg5bk+2S9PztxM3QwMnCw=
X-Gm-Gg: AYBFou1ARLmbULB3W/UlGo1Mp4ecxZ1DvpBqLjQeWDgtc1n8/+kCBoyjHmB50MGrQcn
 zFz+Qk3vYUDhawdlO424a3R//J3RC81zIx7uf9dRGh7WSHqq9ss8B5S0kOW+SUWO+3p4V5oYAp6
 wVY/jTVo6fs2Apafjd60ZQdm+ma1+6O1h+Qi9xO09wqKslHrq4M+lIqinbnomLjbVKjvKgoONu
X-Received: by 2002:a05:6830:6602:b0:806:75db:bb32 with SMTP id
 46e09a7af769-80b2df3d962mr1439117a34.9.1789514866361; 
 Tue, 15 Sep 2026 16:27:46 -0700 (PDT)
X-Received: by 2002:a05:6830:6602:b0:806:75db:bb32 with SMTP id
 46e09a7af769-80b2df3d962mr1439055a34.9.1789514865867; Tue, 15 Sep 2026
 16:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-3-zhipingz@meta.com>
 <20260915222303.GA877199@bhelgaas>
In-Reply-To: <20260915222303.GA877199@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 15 Sep 2026 16:27:34 -0700
X-Gm-Features: AcwNN1Ur2HGTwLfzS3v5GCfBM43O6loZu_h11eJ9ffO6Ol-LlJuiRokJ9Mq3XW4
Message-ID: <CAH3zFs1hpotRvvTziNhSSNR1fLiFekSAMCA7oKsNJbobgeckRw@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] PCI/TPH: Add requester/completer type helpers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0MyBTYWx0ZWRfX9rE/IqQS2IdX
 7L7UbbTtYOfNGR7m1ymVjwfin0HvwQOr1jVCZxsdBFhWbveHxrHt7FeQ4hvVQP9Ya4F4kjwz+Ao
 /JUtce3FqA+Xwt9O8XYskxLY1NF1quX5b+nYKg7F7rgO0Rk7+8x928GHSu1OFoyogQbP8YfsraM
 duIO8ZYwyz3f7/GFL4EAa8ioPFPfpurh6W/Z3R8gStwQETN03BbtKacelHDJlUB5yHMDE5AVROa
 8NpoHoyzXXINFjuD3IWPtkAXgn/Bhl0mxEzAkjuDEiPLz5Q4fbjkxgxLQGbfXhYL1rQ6YAkduc6
 fFyBRGylKgg5bLUYO/3Wodd8FyOcPZA+5OWduot9Aqd6FMhgJZHlCXp+kwCND9PxEySc+T8z2qv
 9w7B5NnJsh21cKloKKS4y5HYBTWiPo/zHchk3ftZDzRfSYyGaeAsenWcKdVjqS3sLAYI+S9JhUu
 kptHmJuYS3xJX3X9dgg==
X-Proofpoint-GUID: m17s47TkzcmIeOohIeEtounTMIU3nYp9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0MyBTYWx0ZWRfX/QQ9in444xQr
 ff7tsRd3muWiTxiBQfLW/v5F2WkUB7OUl97J7DwZc3TFxo4fh/yFOKOFRofzzTFgnET5cX0Xser
 b/EE0Xn5HzAq/yH65v6aMu/DhKy2TJc=
X-Authority-Analysis: v=2.4 cv=FviQbGrq c=1 sm=1 tr=0 ts=6aa9d473 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=B6l6obb3YNMg1WPjzLYA:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: m17s47TkzcmIeOohIeEtounTMIU3nYp9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
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

On Tue, Sep 15, 2026 at 3:23=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Fri, Jul 31, 2026 at 02:15:49PM -0700, Zhiping Zhang wrote:
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > Add pcie_tph_completer_type() so drivers that publish TPH metadata for a
> > device acting as a completer can gate on the "TPH Completer Supported"
> > field of Device Capabilities 2 (bits 13:12, PCI_EXP_DEVCAP2_TPH_COMP_MA=
SK)
> > rather than reusing requester-side state. It applies the same reserved-
> > encoding fold as get_rp_completer_type(), inlined, so the reserved 0b10
> > value never reaches callers.
> >
> > This keeps pci_dev::tph_req_type and the completer-capability decode
> > inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> > ---
> >  drivers/pci/tph.c       | 44 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-tph.h |  8 ++++++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 5cbb381e2a02..d0202ff7a1b2 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -223,6 +223,50 @@ static u8 get_rp_completer_type(struct pci_dev *pd=
ev)
> >       return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> >  }
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
> > +/**
> > + * pcie_tph_completer_type - Return the device's TPH Completer support
> > + * @pdev: PCI device to query
> > + *
> > + * Reads the "TPH Completer Supported" field (bits 13:12) of Device
>
> s/Reads/Read/ to match other doc ("Return ... type" above, "Write tag" be=
low)
>
> > + * Capabilities 2. The reserved 0b10 encoding is folded into
> > + * "not supported" so callers only need to compare against the three
> > + * defined values.
>
> s/The reserved 0b10 encoding is folded/Fold reserved 0b10 encoding/
>

Thanks Bjorn for the ack. I'll incorporate both wording fixes in v14.
The kernel-doc becomes:

/**
 * pcie_tph_completer_type - Return the device's TPH Completer support
 * @pdev: PCI device to query
 *
 * Read the "TPH Completer Supported" field (bits 13:12) of Device
 * Capabilities 2. Fold reserved 0b10 encoding into "not supported" so
 * callers only need to compare against the three defined values.
 *
 * Return: one of %PCI_EXP_DEVCAP2_TPH_COMP_NONE,
 *         %PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY or
 *         %PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH.
 */

  Thanks,
  Zhiping
