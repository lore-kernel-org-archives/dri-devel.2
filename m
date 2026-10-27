Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0192606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IBLzQzOB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V9O+eJbJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 485E910F646;
	Tue, 27 Oct 2026 15:06:00 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41D710F646
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:05:48 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoKRk2948507
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=l0583vDhsBJ94xGrX9oVOV7g3odknMXYWYVTxKC3/IU=; b=IB
 LzQzOBvSr6BEXk9yS9uMGnDZRQPwqxR2DPOfoP6G7c23HwmoH0DfgD4EfGnniGGZ
 WpGX6AC3dkpJdnc1aOZucGgeUVCnpI+JjPgGnPR3Jpipvj9JdRKOGDNnEMcPE1jD
 nVvRwRBnyMQcqfHS5OJe+Nr7nim7g9Wc80XiCGzeqD0hHlGPd/G3+aUFOGhenAUa
 RQA6oEe/hDUM1NsnOawqpgatrA5WOEJxqMoMMsTu2ueXl30VDSucSZ/CkbTGYU7T
 LzllvnaPLz0o8ySJjvdcTlfVcTkTF+ss6WYZzRFq5bsktaLoO99TGikwasm7CZZc
 1yR4n5ftJdmTr5yfgNhQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw21ra1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:05:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so11887570eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793113547; cv=none;
 d=google.com; s=arc-20260327;
 b=MJcq04eVMBYfipkrd05cWkf7qHFdcpT02X9iuH3sDevFnIL8qElQAyGDAt6rXddFMl
 lrb+83VZfiiLfYR+SOb/HVdtsxDs5+GMDBZQyfwwlCIa8s3jt+VpaIjJ/2zr3CsPM3rv
 27scl6V55/mW4mLmo7G2ALeCkGWYrgIySR1lrkwWhxeTvaR2dAX+QHBMlalRtSf5wA/z
 Qrae4EitWtBnU8c0TKrZ8IuGHGiWoVWzp9y88bCl7Q84yhIT27qrT3phcyPs/bTUpfFf
 NL+oh+qSRTuLdz92W2TuvK4VF1ONKlFmYyPQdk6b5zvtQDlOalz/FLlCLWs15vzmla4g
 lWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=l0583vDhsBJ94xGrX9oVOV7g3odknMXYWYVTxKC3/IU=;
 fh=ALDvaynKNLfSLUSK6MTYeiuKUoJPthERD9R9gTB0vEk=;
 b=ajeN3/pjdUQ9xP2f3uVIHdO09qEV/lV7zLGHvB4l7xIB0VQ2a7bD8BNv+1PNR4qQhk
 Ecs2Zr4kiVOaIqym7aL6DCIlMopVVdvvZ7vV1Yt6ys8J2dYK4cJ4YKB+3/jxw9rybzsH
 w0Z4id8aHU52lGGwrRvBibJE2Qz5IWnkVRM9XJ5MBR9wwCn1g5YsQdiztE+1Ur2ieUb+
 eVdcCrhj9W+eoegK2pTu73RyenIq4kY+sFYhMta0YrAaO3AKiZ2haJOYy7UYs1CPOiRA
 zuDKfZXVojn+3oM8yeVOkuhuK6pTz+SNt96L1jNGyaT4r7CGtIJ8mM66rYRSoCgh4J68
 GKBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793113547; x=1793718347;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l0583vDhsBJ94xGrX9oVOV7g3odknMXYWYVTxKC3/IU=;
 b=V9O+eJbJGlVoSiTED5t3d86Ff2uJ16AxgxtrEhH0tPgYjwcd4m2+gn75pPZPZB836f
 q9uKue5qldNhttZThPesDmWXecAgIUnefszpsG1aVVmAXxITm5NcnWlLZI2XL6cepfYY
 3nX9rgP16IcxUIM+e7wGO9iRkLDNL5tX6Kr91FnF1S1mz1JlMRsqrRqIiO5OpXPyVkLt
 lFgXug+zwcKO1g99UbM5UmExlaC+zF6mhHSpaEoc3UwSyws5iAGckOYYNSLT+jr7VyFO
 mWwE9raYPqyC1YSANOWX0mxVfxZV/OJaStRnUyDW3TjStStOyK9Q7J3RNdCmTWyFttqS
 nkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793113547; x=1793718347;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l0583vDhsBJ94xGrX9oVOV7g3odknMXYWYVTxKC3/IU=;
 b=xb6QRhX90xlLDs9UgiwocN5u4izCOc4RIMq5AD7cBZ+ACCJeODxy3+Kubv71Vw+2Yj
 DEer7MvOwianNwV734T82TpR1fsWBa29GT5cPJLZ4m7elkZ5THIiK1XigcEfIvoB59+B
 /2ut/xx4MerD7Rr4Ofc+nevR1U4fijF6k5KowkyxBhWmwwT3Z3bvmr9sPB8aR+YaYlaH
 nWbMLXll8Gs/NgRmKnVSL04WxyfSdzRZXDuVw7bFKXKbjZgNUY3uvwGSDRy3yo2gthiB
 rF1dvKW3eYeIkLG3a8J+mAFuapyeUpKhyWFVYFgBo/ZoT8CvkWYh23Ez/ltLioX7Wnet
 kmxA==
X-Gm-Message-State: AFq9FYJJh/J16nULhUI2Bj1RNyrRVZGy1U1TxS2cVEQZQK4/wumqpoQB
 K/xhHzn6B4s9+pI3NZOpI6QtnM+23WrY9NSUeoxZZ1wZcxGpX3AU1NJrXAEu0t6GCseZ8oXfA/0
 4HmM4m8pY9GQyNXDTfgCebw5PwqmbQ9OdFDjKKxy6F6V4rxe2E7yNpXPpgKnmdLviz/JiGkz5Jl
 6Uv0fhHGMOJilnxfh4XFnuWkP88WcMGRo0kVas9PaD0Eu1eA==
X-Gm-Gg: AYBFou1Yztp23bZOX7Tuti3T0PFMTrAt86LMdOYF56f6j1lKDGB9Ot6eK9kdpPtQTMU
 xnvy5YIxIqyRWIb6zqZ5LWHXzNn057Ahn5o8TF0z8/thVXuUHgWE2U2FT+PGks3a0Tvw4nLsVQf
 ymYlBJVAJjfXpoDQf6pIiiWa935KT7NFB4bwmMjVYzrg/QZdIswjjsjJQ4Wg==
X-Received: by 2002:a05:7022:7f06:b0:18a:d0b5:fa42 with SMTP id
 a92af1059eb24-19935be807amr14866025c88.19.1793113546384; 
 Tue, 27 Oct 2026 08:05:46 -0700 (PDT)
X-Received: by 2002:a05:7022:7f06:b0:18a:d0b5:fa42 with SMTP id
 a92af1059eb24-19935be807amr14865912c88.19.1793113544807; Tue, 27 Oct 2026
 08:05:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027141430.20258-1-robin.clark@oss.qualcomm.com>
 <2dc67d8c-f406-44e9-bf54-12704a8792de@oss.qualcomm.com>
In-Reply-To: <2dc67d8c-f406-44e9-bf54-12704a8792de@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 08:05:33 -0700
X-Gm-Features: AclHuK8pDkPsUbP5zSTLlPCMG5M5jT8vFmaBsciIzHEhLjQPlBsATNz3gAReJ9Y
Message-ID: <CACSVV00VNNWaQ7Y7PrzHeQ+n=E_mh430+OFGmQN5+F_B66Jz8Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/gem: Add some cleanup.h
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Bart Van Assche <bvanassche@acm.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 open list <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfX1CHew0r6fSkb
 fwGvhFMq4qQPSaexcZyqwumUvICdzXNtZuWfvpZcSa5g1c29LPLr5CMCvkmhG9rEn7IDdyK9Voc
 TALoq+4KukJ66MmQ6WnJzCQ9DG6xNuY9VYbhRQiAvlS4wqKSM9gTjwpMBxX31Pn/XlMBBkALAGU
 VP9/QkQMJqFjU+anwugYJroDE8ctDKkyVXsmOlUIrhcJzfSEokxM6kmcvM7MjrB4bO4W5exXrQT
 ETIbqAe2rWkyOj1M4II5NDoQ0CRlweFuu6pSB/At4n9MfViv/Xsblxcm4qF3TUuWb0IIS8TS6Bd
 SM+EZ5ZNqqpuDW24sUxpEoY2iOJTWmqJ4GPIHJRX1/t1N49Lr5gRZa7rCxz3lQszqQnfL07AHwY
 b7GRY1tFNkVfaL0OBtPznip1Pj3q0oTE5yNQXGHfxhzt1CKvdwvJbMLSRNISU2Jq0VEA4yJ3MqW
 DGQh6TWw+BwKVm5fNlA==
X-Proofpoint-GUID: R8-WI0vqZMkOy9-dtN0Okxxru-eMf0ye
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfX0GTI28niz/jm
 AGo35n2plEbd7ReIlgP0bvwE2lbm/fVxy1K/jXuqa4vikoffKxvln7RsFao5zxgRwgyNe609fLt
 Lstm5VLBXrZtQyWv9g122j0UWx0oDnI=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0bdcb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=xJAUt8zhRqVQzByVXjkA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: R8-WI0vqZMkOy9-dtN0Okxxru-eMf0ye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270060
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

+ peterz for scoped_cond_guard() question at the bottom

On Tue, Oct 27, 2026 at 7:24=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/27/26 3:14 PM, Rob Clark wrote:
> > Convert (most of) the msm_gem_lock() and friends over to scope based
> > cleanup.
> >
> > Other than fixing a lock leak in msm_ioctl_gem_info_set_metadata() ther=
e
> > should be no functional change.

oh, I meant to drop the 2nd para, since it is no longer true after
rebasing on Bart's fix

> [...]
>
>
> > @@ -608,26 +600,20 @@ static int msm_ioctl_gem_info_get_metadata(struct=
 drm_gem_object *obj,
> >               return 0;
> >       }
> >
> > -     ret =3D msm_gem_lock_interruptible(obj);
> > -     if (ret)
> > -             return ret;
>
> LLM is a bit grumpy since this no longer returns all of the return
> codes that it can but I think it doesn't matter

It is a bit odd that scoped_cond_guard() doesn't seem to have "proper"
access to the original return code.. I think I could do:

    scoped_cond_guard (gem_lock_intr, return PTR_ERR(scope.lock), obj)

not sure if that is an evil hack or not?

I've added peterz, if he has an opinion

BR,
-R

> There's a couple of single-line-scopes we could shave off but any
> which way
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
