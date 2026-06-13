Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22670CD98CF
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 22:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9180710E170;
	Sat, 13 Jun 2026 22:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="RXC4frVr";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7D310E170
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 22:23:03 +0000 (UTC)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65DMDFnN1793113
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 15:23:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=Jwd8bTapbEIKBMHRp+HoohnDcRxDUqI6nQwnmy5apkc=; b=RXC4frVrigul
 2+TPl69gny41YkeXpqOqbJD8TTbXSg8TLF3Mqa8gIyDAaPL1Ca9do2i2HlOHn+65
 CoxCrdgf9qWE8+7MbwigjUdDtdmp1AfYUyFCWoWend8LDbrYFB8tNlx+eS0wmY0e
 XBwyjB+KqTqOCrpMWoYa0NoDEtLtARehii4jUKwa9uklgqAWQAFaJ6LVMcE8YQM7
 alz+Qg7XmM00FAWye9ws7HX8pcHw0/UMPEsTvpByxH2Ie212YLkrrayKib69EdsZ
 UWVGo6QknIJteioPFD+o+4G2J5duEz4k2lDmocBu7Ml/04FaNl4K9dVPzKfy55Vh
 8w9vDSJ9BA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by m0001303.ppops.net (PPS) with ESMTPS id 4es2v8tb5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e757d8937aso3653858a34.2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389382; cv=none;
 d=google.com; s=arc-20240605;
 b=FZVYHcW+Hp/zXdPiy8aoRGY3iLh1qjLJxAsFrM24k5xkQfsJ2V2dS88NaNDwrreJNU
 bByh2AzMJA6J/EciVkfLtCq2oGKQcSSy8M0EMFOan8r1tC8jlsjUpjU8qCgr4b8I4cjr
 Z28b81F1dfMTHgTeS3DVJwzA9ywL+zHPVJIzBzIXD/Iq4yvluYTMegj/MwXnUa3KKKn3
 XL024UdUKVc06s6mI4sPhiX/VmgEtQ6IjnT3cX5CZWir+dhTXWOssOnjJRMurtvIi/4G
 qxQLmH5gNQTtzd1egpSTzbEq+6iJ/mcvWZf0FHxe7YejRNlpepErrC1W8FBNHA4TR90J
 KodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
 fh=4Zpy5jVCMtfShcZVGrBDbclhquDLvwlIHaon9m7TkVw=;
 b=BTtbOT9vjj5uCkU+Sc02nSkCSOlSv2CyUs7xOU91lvHoel7Tcw6Od7chwXgtUNZEU9
 i2UjP/Fjk9obiGXHMSLoheXUStfj1JgzHsOk1I4gCiba1UVwlj9PtLGjWRyDznbpXBfq
 cZfQv+Snj/bpjf7AGn3u2/WFqFOWjSC+Zu/SerWsDxQMo1NvMFZCjRQNAPIOGYBs3sUa
 tvNNCi0OhH9kgjewrHTaalsBctSlHAdxQYrK4YAQbwDVoWrPft1hPy5FHkA6T1qSg98+
 IZRLpG5j8FDokz8o7ZS/pkstSmbrt6I+UbcedNEif7lKx6UZCqKrhqxELRWwqlRlORSB
 dQZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781389382; x=1781994182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
 b=MJQhgfHxjaaWuuzUrVTtIUDYM6MtT8h9867KIFKY49BtnrM0vBeW5IJRGzdPbt5eWX
 rAeBUcwi4z0AK0ktlg2zVGfye9/25kSNz21h2NiNgVrxjZbhi5/4WTpW+SulHeJg2Xaa
 jDBXiGBcf4ZpBANegZzjLco7NSPDltNlAwaY34UFfu9bEeyZlKFBvc3/drXraQgDpuCl
 0BjDzuIRy8vIcVP9vaqQTVAqMyx7yI0RyPBXt1YSuiJon4lv8qIFELYAP4XEn/Vj5hMe
 2Rak6wGf5Gpj5lq0tR9x4/3f+XZdoRnCeOlYq29xnhHID0VcH1ox9CQ91+K1nQvvzCsO
 xUPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2bkB5TCwSZ38kJy6GOTTjQEzkuMT6gTLeF2aAAkeotPJHScyrHIpq5u5GyQifucl+8mIJdWh1tAk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj23yOkV34VurbyR61dcnt6qHjS0uWIWKE78bR2JRKThbkwc1e
 AbeI+VVdpeDaaLZ7bLMS00w4wON4TRSVaOwtaw1hxEMdkNjoYzUoL4rXjtVuYnRzeODfYX8bmA+
 2hX/HsJz/If6+POQ0O/U08BjkcGO9DGnB4PtwuZFsRBYuQ4klWS5GKAbLZWIN/HaREB6n3Jpd9s
 KXVUKOR3dydAhVRWq6wZmEFR1J+Z2zH69O3iRuLMioYy8=
X-Gm-Gg: Acq92OFsXUuOTv8u/4GvppuWIhNXBImRM/2lBmi7djGJjNbKJ3yB5RHZ0IY0QnK8egy
 tUtZ0gWqGKV/NyMXY4cUQIrK0ErdKx5PY0Ofk8ttiqeWam8x3w8WJ3jnoAoV3M6mvInge9HJlwH
 4GeNjN4uoMcZpke59lCDkzqaUDAi8QYTrPrJwcN87SXuzRD0hM/Z+4JaAeul9hlz12KW9Tvrzcs
 48g7AJHiRGijLDQSfg5ug==
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id
 46e09a7af769-7e7846b44b2mr6299926a34.8.1781389381710; 
 Sat, 13 Jun 2026 15:23:01 -0700 (PDT)
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id
 46e09a7af769-7e7846b44b2mr6299886a34.8.1781389381161; Sat, 13 Jun 2026
 15:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com>
 <20260611161546.4075580-3-zhipingz@meta.com>
 <20260612105248.7d8431f2@shazbot.org>
In-Reply-To: <20260612105248.7d8431f2@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:22:49 -0700
X-Gm-Features: AVVi8CfDNU1g_5HOJkneMc79yczUqiaSKei6CEAn7F8ZvFdakbFhyfrfCnrLCmw
Message-ID: <CAH3zFs0+zF2JQMpVZMM9ndh+07KE1ULQNOkKrLozWq+_kRdMyg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX8BCJtQ1MN2Sd
 ouutZYHq6obejcJu4t2Y1p8zYYFbAx8euMwFBhsz3CBOL+U9/mlkBhHSR5wdH5pWnMEAn8WY9bs
 62e1GJDHg4r2KykOyReRTPU4DGz7TDs=
X-Authority-Analysis: v=2.4 cv=GNc41ONK c=1 sm=1 tr=0 ts=6a2dd846 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=JzgkHKIk_dV2mhMsj_sA:9
 a=QEXdDO2ut3YA:10 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: nJkAM6t8oZUt49Q56h1FLmfvijFemixy
X-Proofpoint-GUID: nJkAM6t8oZUt49Q56h1FLmfvijFemixy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX4zMh6aAdq0WO
 NYElr4b5bkK2CjJX17IpMriPXewqnLBv2FI+0d5bV5Q88Yf0RI3qpvxgvnu8WbqRseNDlEB6gKR
 GX/w7BCu/OydmtoMq2teb6cPyeEzjm5KXDYnKnanMX1C7GByjDEF0uLF1M6KmwsGjz+nMrXmpwq
 Ie7z3jsYuFhkpAU5UADMya40jKlFXShlIUYVu9gYsXsV1lk1MbpWEwHHn76A8KLnO1sCZdtsBrD
 Dx+uBqYiUkgk+xPnao79r2O5bj1LU/bXg4YkybyWrK1sFmHLLqAmTSd4+LW7WQqjt8qylZwyLar
 adUXvbNhHyomu6q3HB8WcdLIDi/L/3PX0kUeGMoeDyMfvsficEZElnHh7WLiciQPW2EsdcAtZcB
 jxi2Dqy2plrIphOUkipmrfMprpvCfwLidjql1FBAh0okSu3/O/sP4Enb7KddkYzJUbnNw0MmzYu
 EnB7km0SLMKZWuTb1aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01
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

On Fri, Jun 12, 2026 at 9:53=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:17 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > Add pcie_tph_completer_type() so drivers that publish TPH metadata for
> > a device acting as a completer can gate on the "TPH Completer
> > Supported" field of Device Capabilities 2 (bits 13:12,
> > PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
> > state. Fold the reserved 0b10 encoding into NONE so callers only see
> > the defined values.
> >
> > This keeps pci_dev::tph_req_type and the completer-capability decode
> > inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
> > callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> This is carrying forward an ack for v6, where half the interface here
> was dropped and changed shape.  Thanks,
>
> Alex
>
Good catch, will drop in v8 and request from Bjorn on the new shape.
