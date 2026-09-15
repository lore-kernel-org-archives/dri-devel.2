Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E6EC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 23:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFDE610E1EE;
	Tue, 15 Sep 2026 23:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="SIXx0xrA";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C60310E1EE
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 23:15:12 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FMPAsx1448954
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:15:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=9wSKnU6K8x6VtxP/QNuLN7MLmNw6mKZQmf+9X
 IiVvUU=; b=SIXx0xrA+TwjdlTogR7fvr6LvG2I7Icv08Az9vCa/jwMZH5282lDb
 fITP5NGPExDCwMPo2NWJYTt4cs//NI3xZM6vnLSwvCKR03RHUaKT4FRbZQXF7pW8
 wsxiplIBxZPBMsM/WO1a6MO0wTOImFGp0ZNUrmacGmQkr1i93e3ApULxS50+MCOG
 RDvPl4MJ2C+2R6YDeiugKDUPRPGote74ERplmgd5+LniAtVGTlx4x2BIu1DmUtp6
 4bCDxqPm0RNRhVOR0xeEdOywHGun5E4lFBdCvFLcju9Nq0rmk6h1Ixd6uFDthHXF
 laYCFWUso+8lYVXC18+EsNnAdYEHhqNkw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gpwrh7u8u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:15:11 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-80a4a17618dso1350957a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789514111; cv=none;
 d=google.com; s=arc-20260327;
 b=Trjti52H3Asm+gYYMNx7eKM4jMIu1KQInUPYeF1c2L3yKU+OJpccOkBUw/LRrZN7dM
 i82VBYaqzL7MAIWYjcm4o8Q+PPIBcqZplsiXHNcSeA65k85mWRsFgN55fb3X4t9feVsn
 gGdZ0Km0ZfTNIpnOLNUqyStT0NWrXKu4FnTDXx+3yfOqXvny1ZVeUDsifPv1yGsHqwwg
 tTXj/tL1M/I9TbQOmNNpeaBYz2vkaJ087WhR9ca5lb+8Dlr3U6W+om/viwQCopY0WBmP
 x2N7fPTfQQok8lFJVDYowDCwMw+CJEooCtcYXjDRFXREGNzryadKZs1quK6xSY/njQRX
 DvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=5Z9FH4pGg+zZG5DGIDh+CM+cqcFCAu2VEGfh4kw4QyM=;
 fh=cGPwmXmsjoEcCPEgTW7lUxx9Z3P6aPnqkFDTR7D/IWI=;
 b=mfQCP4L+3k8YCOnhzUO5Ua+sYezMGsE1Uh/ur9sGWa2BEidCyHksQas4LvOS2Yj+Fo
 jp5ExaHO0rryOGQOpdTIIPLZXYdkaHKpjjzquiBjdl2kmMUtDJtZF1uSijPNN1xW/kVl
 mW2rpnkDiWp+YN7QAOXlHbcEQILdpK7SFcdItm9FGwcmGCX9FYgkA+oPZ46ER2IEf3zr
 pFfBmi/9fUjlZIv0QaR6/i0ISc3E6QA5GbX7Ichq+pmOPIETEVXwts2bmCBbgUYWEaEO
 jOWDUq7TxXAbZAhGR/5lauZM0D0a679qF9z4fJkBI9dHQBHWWUtm1NBjpvFf92ZSrZH0
 qxpg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789514111; x=1790118911;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Z9FH4pGg+zZG5DGIDh+CM+cqcFCAu2VEGfh4kw4QyM=;
 b=Ps2UvaMkQJSqQgpKpf9qsO7Anzcua6+x2PQm3vC/JfylmLLWFW4jXXgU7UL92UyaJR
 6z0bYmsgwb0R6vfCs71vW/RC+Kc8JyZEixHM+BrDOB1QaILkBlnekRuyyya7GjSNWx1w
 dpBkcgK5ZuszxjFehSa0kxf+xML78+QBzULr+QvAsaEKL/LAmxzzqxfw/Qz45R6umbTf
 vJUE8pGIbkZTDjtTVm6nK56nkM2/UfAf/BerrVotW3StNMs5AfEpUxOGEauT+/Qx1Znf
 bG1VNb7ocrduToByYJmq3YMBMwJHdncUV0MduVLoxl2ujTbrjNPM9DRCU9ssQCWR5b5J
 rpvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXQr4OgPGIpFIa45IF6+1f4lEbenk0AtNyifoPcxtezV4DOUdIfKf/8d/dUYfQZemVq6fmTcYRZpg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k/fuP7M2L9y5KsYSRWaGVzrMqsjIqiRp1j/12ZPOiX1/l5BTQf
 Z2Uweno05X8O2zfWDVL800olrOpoPtl5fYYtQj2ETOw4++AR7kaquK5fCbgkPioAhdZBQNbuvVn
 ahh1LPaguD1mWSACjK7FZW8ODypsnnKWoypWG0CTLitNkeL337WhrONQ8c/b9EkllTeITGKU76G
 QnBDI6160zTiXUGKTY0uQu/tMN9fHF2QH/e6nCmNPFH34=
X-Gm-Gg: AYBFou0mtatxCJLQoo/nJaz+FBTVL8L96luHBgBaSm2xN09YHlibNS4bqDgo891YkKK
 OkixQui0+Z0j6kRIDbb5PSbx+4U4c6vDOBgaz9VpC/EU3iqAzhNH3ghjp5J9w798MFPw7mNKv4D
 hnUE681vVy2/IZk+TF0DUEYKvyU4ub6MUFfKsbEySuSgVwnDZChNgdcs+O7nBqi9QL6GKXfzsB
X-Received: by 2002:a05:6830:6001:b0:7f9:555:1def with SMTP id
 46e09a7af769-80b37d7fdc1mr343292a34.11.1789514111047; 
 Tue, 15 Sep 2026 16:15:11 -0700 (PDT)
X-Received: by 2002:a05:6830:6001:b0:7f9:555:1def with SMTP id
 46e09a7af769-80b37d7fdc1mr343224a34.11.1789514110002; Tue, 15 Sep 2026
 16:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-2-zhipingz@meta.com>
 <20260915221924.GA876929@bhelgaas>
In-Reply-To: <20260915221924.GA876929@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 15 Sep 2026 16:14:58 -0700
X-Gm-Features: AcwNN1XwigNQ9uW6nBUmoxE2F8a1TK24gfEznyxrn867tS2zzsfZXU6D-kJDtU4
Message-ID: <CAH3zFs2EyhpkJXRr7gbC+Oyb3y6Y+yyVzAgXCvg7_won0er4oQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/5] PCI/TPH: treat reserved 0b10 completer encoding
 as unsupported
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chengwen Feng <fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMzOSBTYWx0ZWRfXzlNBe6pIuD+V
 hDDpoMHY3N8stinoT0BVU3qh+JTGJOY07gw9mUncsYemiqOPfp4eeyu6khEhyKD1bqqthtumZ2B
 1aQ1UcIiG6m5mrwo8azk/BSGUgOGe1o=
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6aa9d17f cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=i0EeH86SAAAA:8 a=1XWaLZrsAAAA:8
 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: xi5XQO7ZclBz5C0SQLJYKGGclJDj8mwa
X-Proofpoint-ORIG-GUID: xi5XQO7ZclBz5C0SQLJYKGGclJDj8mwa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMzOSBTYWx0ZWRfX1b4yvq1HuNk4
 OsEBXt87e6MHqCbSwKm8JXiZXWiqdfGP7zBM6xcK0J/jV/zAKCf/eukgvSX7yfwmceVn1vN+V7N
 kyJplaMKIZSboqjlVOtXZwXNDp68O+l9itpcoE/ofaol/v7hzvtagm4WYHUmF2AVhPCxLJATfDL
 /d4lokH6g04FFgZiPSjqxTxZlJ/CVKGpw+NcgLm6EA2aop0oq5rLiwXf/poAVJ1cM78XHtr5MrI
 xxfFsW1E0VZiawKcCUbRAwocfm68xAnPMyAuigCv2RmY2rZ5vybYCoQ55QToJLMMGucktuWw7PO
 HQsEoztfmC19QzCvanjQszWdqSKTHErLqF7+4Niff2kIDaPxR6ZWTjyH1wX7zBySQxJkloxQd26
 rf2TZU+UukGl+/3tIbhRsXmZm+KKbUxDiyUmApK2uHgrSwsHHvsSvxRvewHgjDVeSG2jXdAf5aN
 y6UPwmf80awYmztyOGw==
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

On Tue, Sep 15, 2026 at 3:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Fri, Jul 31, 2026 at 02:15:48PM -0700, Zhiping Zhang wrote:
> > get_rp_completer_type() returns the Root Port's "TPH Completer
> > Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
> > 0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
> > into the requester type:
> >
> >       pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
> >
> > and later writes tph_req_type to the TPH Requester Enable field, which
> > only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).
> >
> > No known hardware presents the reserved 0b10 in this field, so this is
> > defensive hardening rather than a fix for observed silicon: fold the
> > reserved encoding into "not supported" so only the three architected
> > values can ever reach the Requester Enable field.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > Acked-by: Chengwen Feng <fengchengwen@huawei.com>
>
> In subject, to match history of the file:
>
>   PCI/TPH: Treat reserved 0b10 completer encoding as unsupported
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks Bjorn! I'll fix the subject to match the file's history and
carry your Acked-by in v14, which will otherwise just be a rebase of
v13 onto 7.3.

Thanks,
Zhiping
