Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69417C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66ED10E05A;
	Sat, 26 Sep 2026 15:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ju/jyXMr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FH3uj07E";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066D310E049
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:23:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QDe3pG346001
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=kwRYD0lg3ABAu3cXBo8DfhKih+wg0SWi0GfEDlQ7sK0=; b=ju
 /jyXMrgh6sOhp5pfzYpboLpZbwQkSeNZqeqFUWFTMAzlCejoUEMOb0agvTJVaKr8
 7xZSKhZS0iKaPsHuaJFnVH1MgOtt+T4a7GsAa8vi/qyARbtF9fqmjAfCecmWg1bx
 1H1r6SxQSyvYEFf7g+asXn7RTxhZ+TFUIHVNLnXtYY1vSM1cUWcI121E0ItEhMQd
 XtlSuVoRCGEL1qYxDZT5vUONEeK8uura4F1qnf/wvEVTpQE3TSmPxLi36ab3ZQzB
 p4YiXAZ9YMHzowRdBDhyOESQWuPImBQkVFqoYqr8amc9cTElcqgBBcuxLmjIhwHW
 geqzr7CAeMDLP/QsTX/g==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526h896-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:23:57 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-451d80641efso2948579fac.2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 08:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790436237; cv=none;
 d=google.com; s=arc-20260327;
 b=LWk5C6PiVdoQL2LaLCrxYC46bbkY/+PkHh4nY+IRPODLudUUxrucvxDPvDegUoWaoy
 8OX811aBYCUaSZutGAyxrwBtL1XPtnneUJ3qK9mIkVXxJ/zs77Sig1LGOWn0rH17Ypi6
 LeoUnKaElSNlQRI7ESrhy/t1x8VT6xbxgjjK51o6uU4bSY7Gq9RUvOFqtkzbeyaz78HN
 GGjYY7wTGl604ey9M2d+i0RtXHiSVrUEgGM3/TqGwAkaGbU2Px4Agz+DZOOpkEzVg+L+
 5Tn4veXtcuNWCFVlCH+aHKLffQpdjhoK/ebuuCGdItzA3H0cnruZrJxSFix9eI3X7ZxF
 LuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=kwRYD0lg3ABAu3cXBo8DfhKih+wg0SWi0GfEDlQ7sK0=;
 fh=spGf0NbHyCtIurX+3J/+4/wh0GwVHxdB2GQytcD0XNE=;
 b=ZeSfj+jxKY70FqaQRbIa3kggocjNn0yfAxTQNl4TShBKckCed2OFmQw9ERRyWVhUHI
 Sr0mRYsoTc9twIbtpBfbSfjteXzRAyZirrZ8Z94XWaVxdb7Uci1VjPDb4KSJ/ufJEgBQ
 tjuHIK695cWU+lDX80dIwy/aOcIBYIz6fQ8dk83BVFGoZ5nNpaI6E9SZygIYsAVmAukg
 Wuzc1sHsW8zCu4eLDnBpJRJLdEOHg/P8v+iC0QfSiFvO/Y2+2dlyiy4ge8vi0je/6WBM
 3MrIMwk5lMAX/TjZ77l6cw2JMHL/KXqJUmcl4vZQIvhWUdpZ4ph2OBLPCknyjaeP+ZuB
 dSIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790436237; x=1791041037;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kwRYD0lg3ABAu3cXBo8DfhKih+wg0SWi0GfEDlQ7sK0=;
 b=FH3uj07E2N4HrpyAHFRn92guP7ImPdspzjj2zbe00SqdVDzznAhNQpz0m5geZEaaqI
 1wc3UzGj8DfQK1s/xaEQ5bcGdpd/2NhGes/yvzSTtUi35DWizVbg2/QK0FMu+SLME2xW
 JueWw4TqY6YHy4TLHvj0Myahf/Elx7+zaBwa3TjBhL3LoOmKO4VpBTtANGiH2mgZ9RkP
 xGtN/A+TUjjkjNmbDdegwdHIR2vD48ttgcc9V3ubSJr54zEdirlAnDX0AzTMwXsGX1Sc
 cuVU1PtuOsmXB/Q5bsI17qsUsyZ7VAG6V9PpT5dQnaDC50c7+kOOO7MCpoVtdnBg2QiS
 DQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790436237; x=1791041037;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kwRYD0lg3ABAu3cXBo8DfhKih+wg0SWi0GfEDlQ7sK0=;
 b=D5a5gnoVXGYzCeTWdqVBde5mTEoWhFXpDPUx92gIhDZ2DcCliY39lZ8Hf62KugNiOu
 lMj+yRH5C1jBOCcK74rsf6GzEZoS7fjYvvJSCMD8O/Ymle70amvz37Myn4dj6EwCDYR8
 T8m1ATnN4UJ7Ir9B4RwHRdptbPsqRk9EwEPwH6y48uALyRYQpHdBpQ6X1EMOKTqc+dGQ
 Kp2bNRL8u5yNkputOamRUQTYQa0hHDURK/s/XpLMG5XvEuzcGnNm7lKP8nPyQT4tnBKh
 t2DUrGNYmMZMM1E9kHRoK53VlA8uA3LR2tntr9G0xH9QX0Lql/KitiEc+KPXK/U4ywoz
 8urw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXtIU1U5g6oTbx8kqL2+9hkN/dkHaIgz2OlA0+4GKOaNSsS5QKEEuuSKeh+TJaSXxN27skkg+h6rc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nEsQcOoFbmCe3g6SdBUrCigVJav03PL74YjsUlAA3NDVdFGvhd
 GtZXonNp56bxe4uPwl3GEYaX7NDAZYYM2JX4V5FinB/O9+ENZGF0HDm9HvHYN+7fCqsel5BY5fk
 UcWCthcSZf0zye9wKp12mBBxa01uLDgxr2TIPnAhaPkGkKxuq9F2OAc7voyio9BE2IycpUlJPy9
 DdnSIUim1KHfiGFhYfv7d9+T8cPTXBkrwZZ9nu9zRH1RfVrw==
X-Gm-Gg: AYBFou3ancWPsGFyy0VfwELd7Qz89CPjTS7yx3zdctbRzoHbAAw+LjNH6Ar/ZpMFYu+
 PSIA6i1iQLAQicNvJJc5LxBG9qWhyUeD8jeg40B53ltY1LdiTQU/MBZkBRZxlZc4op88CSAxUvQ
 oz664tXTioA+cLi0pprjL13MwOoWEuos46L20t54tfH32Q+/iB5ASlXEv1
X-Received: by 2002:a05:6870:8125:b0:48f:e107:9094 with SMTP id
 586e51a60fabf-491ec0cb354mr8222536fac.58.1790436236700; 
 Sat, 26 Sep 2026 08:23:56 -0700 (PDT)
X-Received: by 2002:a05:6870:8125:b0:48f:e107:9094 with SMTP id
 586e51a60fabf-491ec0cb354mr8222516fac.58.1790436236156; Sat, 26 Sep 2026
 08:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260916175738.2089950-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916175738.2089950-1-vulab@iscas.ac.cn>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 08:23:43 -0700
X-Gm-Features: AclHuK-MO8yQtGnXizwPI78LElvu7aVM2e5_m4tfC0oKEkl4LViWX4O6Arj8prg
Message-ID: <CACSVV01+7xbVKDS1SOJOpuAw4WojvxRa25fUVZZT6o7hVcNOXw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jesszhan0024@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lumag@kernel.org,
 marijn.suijten@somainline.org, sean@poorly.run, simona@ffwll.ch,
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6ab7e38d cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=TGumlaujzOIqipXuJGIA:9 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-GUID: Wdvo_B5UbHINxUGHT3ZHwAsgrEfIYA0B
X-Proofpoint-ORIG-GUID: Wdvo_B5UbHINxUGHT3ZHwAsgrEfIYA0B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA2MSBTYWx0ZWRfX0yhhFFNPHY6x
 GNkiGXIn8nAk5de/j9WM6t+O70A/KXhJjuxAFk3kAXtITf6eL/Fc0tkpT/ObViHMsYWU3WcRCZZ
 WYSw8UQdl/R8Rhm85rjsEd3omMJnlUpn1ENrEj93vAAMOFKTws+ZS2O91gdcuneaCdKa9LIqYzf
 T/EkjtcYuOVqUHJRAldq+Pf6wnW3ND7Q0CbC+hy1bf/9RR5+XXx9r745FW+V9ggmppAauIIv/NS
 JgE83JVQO7QbLifdt64ojgL77HUtqlov79S51G4Inj8xgChsH7TPr4zSznhXfc5Gn7QiswXeZBA
 2uyZgNE9Y6B3aESygfnkVoB4LjllE/5TwqneeLJuE+SOhIg3ougHnvTtAGHVdrMMZOg4LF+AwM4
 O/niYGTfQtP5f/DFgFpTKgFXeSfuoCx+ijBXUlg8wZzGP904zk0qFzrGwjhJd+GziKzADojBOLE
 2mIVg4+RO852irZ/gMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA2MSBTYWx0ZWRfX67EIRngri5rn
 Ri2V/zf4UNVAgnaMCZEqKUc2PUrGnP8Imcwpri4ZUKyqbpPI85gthpChcVzSxmZDhyqhvlRIZp0
 XPIJF0+dxnzB/Q6CCA3VIxFUUIS4NGQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260061
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Sep 16, 2026 at 10:58=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> dsi_tx_buf_alloc_6g() takes a reference to the kms VM with
> drm_gpuvm_get() and stores it in msm_host->vm.  If
> msm_gem_kernel_new() fails, the function returns early without
> dropping that reference.  Since msm_host->tx_gem_obj is cleared on
> the error path, msm_dsi_tx_buf_free() will never see a non-NULL
> tx_gem_obj and thus never calls drm_gpuvm_put(), leaking the VM
> reference.
>
> Drop the VM reference and clear msm_host->vm on the error path.
>
> Fixes: 5e05be782645 ("drm/msm/dsi: free TX buffer in unbind")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi=
/dsi_host.c
> index 982abaaac00d..29e0de0e0c22 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1250,6 +1250,8 @@ int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_ho=
st, int size)
>
>         if (IS_ERR(data)) {
>                 msm_host->tx_gem_obj =3D NULL;
> +               drm_gpuvm_put(msm_host->vm);
> +               msm_host->vm =3D NULL;
>                 return PTR_ERR(data);
>         }
>
> --
> 2.34.1
>
