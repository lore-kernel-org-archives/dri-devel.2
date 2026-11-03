Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5E606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=alDpBw9D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wkx7XcXp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6584210E80F;
	Tue,  3 Nov 2026 14:14:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D64810E11C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:14:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3E9spJ4049710
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 14:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=pwZoBqfoFo0YvlCchBXW5lqCWHboNX5xMKkZiBuo0BM=; b=al
 DpBw9DPHjAUfwbzkD0sAKBDIVF62V2+19WyArxit3bDezESsDCPMf1kSqRUhu9U5
 RdTqdILrnNSAjGmrOeLPaKWoqhwEv3Q9+sAAYbE3txbYTUjHHewo0gbQPAEqQo4g
 OpI7f7ghVq/LqZXoL1tyICHHw/E4ez5ACiB5rzCkKNQGnNXl6Aw6T72vIpNSn3am
 H8aXTxi3XvZFdhrwWGrIeiXRFBKsMWpMWZNHDi77WRiNauREEoedC/Z2UuY6Bp2j
 k13nSdOm5GIVu+nDivITx4PLxx4pEd4qWF/w48+KlXz6xfzKNNayfH2QwQdXVsFC
 Sj7cHzrlwKfLBrUk8srQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq3uy381x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 14:14:27 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso8088898c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:14:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793715266; cv=none;
 d=google.com; s=arc-20260327;
 b=ix5l9M+JbvchbOjn0GP+POdll+Yf9VAECddDGIP++NCsppVp4L5e6YXIQceDDzcLpn
 N3tFwVKg2Sv1jE+LffZzyc0SlwiF1EsBITREIqHR2dS2CFcbvbxzUxyAxqpAPEicJZaw
 8idkro2a389Wzb6I9sMLIqOg4+2i9zq0+fue7wXIJO5z/2oUhU+wpbkCz2jgIUdDMuKf
 ENGtwbiwKiKIynJ9KZvbjaspmDFqQvoC88XU8j+AznQ1VEz6S8WDrQ4kEDdbZV4r86lm
 chxxbLdsw1jIhAx2fce87o0MGkvT+PXUXcmh19a37L5r4lASZhbJoE+i4TC0x1gx+Z1z
 mzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=pwZoBqfoFo0YvlCchBXW5lqCWHboNX5xMKkZiBuo0BM=;
 fh=sF3Fxpy4r0qfflQvszWsZOL/ZtIa2ivnu6avzz/V+zQ=;
 b=BJglolX6Hq3Dcpa7z0pX0NBzBIGtOhVpEFhX+8OXNJe3uW7dRwXcLfuA6g3aNxt/0P
 MjHBaiQhJ3+Qpia3RcT3WULORyr5X3RLzL5Ko/HUupDlKahBJSAVWPOZUxHiiYQ8ZefE
 pvgB9/s0FxcJl7T8bhBrgWmf+LysYvAkQDtzeuz4eCb4vbuEF5OlNUdp3Z4VKRMDSoLn
 HDoGNdxK6NG6nG5KZ3SXGDjzKfpzzkIJqU1WK1oKFhzEtZkTkVOJc97TG5yoo3tyW4XW
 OVRHMDl23jcmkR7jWas/xOgWmU4tsIcY9uzpan3xEYmS0arpeep72KDEOLDillabD8od
 yWzw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793715266; x=1794320066;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pwZoBqfoFo0YvlCchBXW5lqCWHboNX5xMKkZiBuo0BM=;
 b=Wkx7XcXpp4XHiRozF342xCahMkXjEtHbR2M+GFSdij0wPJtN5V6gItFZ/axz44vH5D
 DlzI794dUb1/FFe4GvnsJI3XIhk+XA5IgqHzi2biZTgyWAa2m97pZuQrHsXCzOibyB8G
 dCDvdOtCO3JeQ/Xpstx+zPUtxSB8txINw7z1ve0zLstgMyNxvKteZ0cqfZZAvgoUiPlT
 LhtsZE3867kO4kYVDcbuM1Qf672VeUSG60yb3sttNSeZHLEWofCpBchKNrf8BRTy5TvV
 DfKXVf+BBAk9swyx/evZbfW6qZ8nDOvwlDbr/MoY+BiV7/MgxKL//ZAA7rG8wpl2LTw4
 LniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793715266; x=1794320066;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pwZoBqfoFo0YvlCchBXW5lqCWHboNX5xMKkZiBuo0BM=;
 b=zRDKKeRrHODg1ACbPd/SEa937ax+pYvb/G1pqsFQyCfZQj6srWtI3JUM9xdx579ll4
 I32Gqww0IEQgjITGT9V7LfRxYGi5N+OrpO6aOibTwFXBGpMd8NHvcXAQ6I5Hg1LV1oa9
 YAVp0MoxBZQplj1psNqIfWp8FjpVsQCZiGrW1D9AMO2A+SqHZXWbk3gYrsa1UFCNlsdq
 jeI3nkeAa7pmE36YbWrlZ+imKWVQukQ7eFKSZIucCSMV/M+sY17YJ+pXip4hK32FFHiW
 E1h4BcuCJ5oJ478ElRoVbRzXCMXcRzKjWK2w7IfMr+bJAKeJYAhi3TbkDvJ6wG3V37Eu
 dmXA==
X-Gm-Message-State: APuU4Z9c6XL96DmZUQOpkK+I02XIJ2mMfs6zdoj4vx5knyRSIrf+xsYu
 BlqidE1080pn8wMYZ2GayZNjik/iWndAlXhz5xtIFPu4aZRfcpGqyqU+eyWd4hHIeckQqhylelL
 p2NHQC7ly8KUvgf+0n4yBoqMwazsqD8Ftx/uRigYsOl6tLFMpvVFSENlAlw2I+Vn/MHys+9tMqY
 vib4GErq5DS0RPDlzRp6JIrPG2opMO2YanCtWjtz28YdBombtf7H6HGrwX
X-Gm-Gg: AYBFou268C0sZct29gX6TWhkA6IlpVZAful+aE/brUwcLv6P2jcdQyE0jC6cgDruFJq
 Zbuzn8GGB829QYjIVmhV8oEQGj4xgGcl2EBfxNF8aTi0Mb1GgPkZ17eBgxjhVEx66qUmDSXhJ6v
 fzV5js8UhECNNrVLWcrk4JXv8quTBUBYDnp1oaPO8BT50Ona823g2OpNP4qA==
X-Received: by 2002:a05:701b:2050:10b0:152:92c6:8b58 with SMTP id
 a92af1059eb24-1ac5c555078mr21077424c88.35.1793715265900; 
 Tue, 03 Nov 2026 06:14:25 -0800 (PST)
X-Received: by 2002:a05:701b:2050:10b0:152:92c6:8b58 with SMTP id
 a92af1059eb24-1ac5c555078mr21077404c88.35.1793715265400; Tue, 03 Nov 2026
 06:14:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
 <20261102172001.508440-5-robin.clark@oss.qualcomm.com>
In-Reply-To: <20261102172001.508440-5-robin.clark@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 06:14:13 -0800
X-Gm-Features: AclHuK8L2yW1PaKznz8lmJSJhTx7osRp-6K0SX6zJK8oMud99n8w6-qv_LxHXDs
Message-ID: <CACSVV00rYMk1E+Ajv4mUCPEiBkaptqRFskB91om+uAHdc1T93g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/msm/gem: Clear nr_ops in lookup_ops() failure
 path
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ewfIxDtGb3WujBMvTb16AvdrpEZ8h0Ms
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NiBTYWx0ZWRfX0S1Uyy+6gfEP
 p7+vNYHQVT/kuD8PMEmtXCFBK+y3U4zOSyoUWalsSBYYyN++Il5ZF8b09mCejKo3FSLSf7tM49n
 Iqp+d0ldyGH0EyO5B12cZi6D2AakcQbK1hX+ispp4ABhYJLlkTZb4LIG9zjgYbjSTYsK3XA7yej
 fnfGsgnzgdVDMwnPcywbMXZzYWuWzlIIp+R9MENM61koTc4sCfwCzEEtJbxcIyGO87zIoxAasXF
 vLdEmO2UU24y8oSCY1AWnwxQtOd12VaGJSSYVIj4kSVMaxioHN+plHmhlE/9+XcmOnoQIeM8Pbw
 WejG1sDBsuHS2maUph3215357mBBNnn6P6VNbdmn3R2SyNXEKDxMI+YyBAJKz1TegcJBd+kaBzW
 G0zkuSVyz7O6G5wv0LW+nk0ekcFRRy4EioObAqcu7jLBk5qxiXaq8+T54A6F17cvnZy9PYGTqkA
 nzt7Nvluesrz/af3rPw==
X-Authority-Analysis: v=2.4 cv=VoG2kO2n c=1 sm=1 tr=0 ts=6ae9ec43 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=b_1sW29P2VfG_wUA9JQA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: ewfIxDtGb3WujBMvTb16AvdrpEZ8h0Ms
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NiBTYWx0ZWRfX3vqqh0tYv+Bi
 CFoPlngDaHk9osTrKzDREcnpAVLh1mc5IGqx/2+blF1//QKFAcfoHHxsaDiVHHQ7/XjgLmZYckV
 Qa2K+W3BFuBeAOhTmFdsRpdnf2E+I70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030056
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 9:20=E2=80=AFAM Rob Clark <robin.clark@oss.qualcomm.=
com> wrote:
>
> We've already dropped the references taken in the handle lookup loop, so
> we don't want to drop them again in msm_vma_job_free().
>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")

> ---
>  drivers/gpu/drm/msm/msm_gem_vma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 3177461d7ad0..8b702422030a 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -1088,7 +1088,6 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job,=
 struct drm_msm_vm_bind *args
>         }
>
>         if (ret) {
> -               job->nr_ops =3D 0;
>                 goto out;
>         }
>
> @@ -1143,6 +1142,9 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job,=
 struct drm_msm_vm_bind *args
>                 }
>         }
>  out:
> +       if (ret)
> +               job->nr_ops =3D 0;
> +
>         return ret;
>  }
>
> --
> 2.56.0
>
