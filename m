Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB0606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i/q9l+Sw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cPYff1lP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7854F10E2AC;
	Fri, 30 Oct 2026 14:43:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C918410E2AC
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:43:06 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERKSE2495308
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=KbultFdxARc0+R6qwvP8HKFaCeHvN/9tHGKKeMncdgM=; b=i/
 q9l+SwlxImRNuH/8humXE68p8ikHqaC3OSwA5xqd/ORguVoNvdE5CAij/2FZgECT
 RSwS0D6O65xqDzzHk3aCD0TVCe/1d+kxlTz1qSLvEYGrZWm1Xu68bO+oyBkQvJeO
 scx+OsSHS3phCkp0AjdaZkOJFboxghlui9Ctc5hvNREqq9NIMyQVbCkESARQpVqT
 yYMdIUTNRsgL4dLtdR6GFCLhmNo/iGHcpMcYGXrsPlWD7LYrmduNZvQ9SqH9T+Mx
 aHYQb9b4RghMtbAVBDOv1dBkBl1flnMl8tZsZ6kVPPTRlY6v2ktfXODXZh2cQ76V
 B5yb8rhEtu570PHwaU+A==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3kkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:43:05 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-45e6091d8a1so443609fac.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793371385; cv=none;
 d=google.com; s=arc-20260327;
 b=GUx22KxdI+TYnT/M7T8MSbxkdL3ZvWIFRQWW/cfCjp7cwzz22bvAHGVQ3DaRklcl90
 5oaEXjx7K51L42Dc9m2dj528Ww+pDRupMOf5yRMCg1bOksxVnWWe9gQ+AD6AJ4Npwum/
 WZOlO+EYwYSfpZndYeODjhjkelxKAIWoUlAR9l4NsVW8nJWJsZlSDJjCE7A8wlsEZ2m2
 93DGEBbSN+1BkDbenMO9v25VdHGLz4a8AkjL9VuYO/P3kRh8UBMjWk/4JBOJprTlbXIa
 9CuE4jXjcMkpGfzKvXqf9yT3zxJAyHTczDTlW5MJxkEhckeT/0gss8tDsu3rExnLLB5S
 7VPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=KbultFdxARc0+R6qwvP8HKFaCeHvN/9tHGKKeMncdgM=;
 fh=Nx/8WhhgsodE0SBSV2NMBLjqRsQB08lor9AnDUfMUuI=;
 b=ntT777TfcPH19jAjyIW8VV+8TxunZVeYcoSbvTEuPWTO9aBYTyT1CYf2sqlQAb/xio
 O2iKll/mSoBRQeENiOt9ezuceKzjMSbcDmKhehlysEdkn1U55rI7+4Z+azV7lFYrMoth
 uE0S5aegdnoVr7xeqh0FTRsYyh0noy8Mx2BLweYhK5fhxw+mkw4JQpU6YGMeyL3dIG9l
 OFsRR1wxmGW/cq6g+hV70wzLx7aFwYghqNUHgaOL2EQmpyDxuRt8XT2eFYf58mFWUDsq
 PwDqOJWaFVaTVPlT1i7mIe48b8xdP30DOYjyqutSJcsPgLFjVwW4RjIn99pWOt8Fx8W4
 6mRQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371385; x=1793976185;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KbultFdxARc0+R6qwvP8HKFaCeHvN/9tHGKKeMncdgM=;
 b=cPYff1lPl6T1PfKLvZp7ScmngB7fK4eAolDy1FP+fAVlxIa4weS2nDkrlNreQMHl6g
 G999c1baEKjBbZ9WjPygmydKc+UpamcECt+kF6RFrZP9sbqdpSDSXmJ2kdgcIMVR2Laj
 bU0382NWLWvoj7VgAj10nrNCechtT1y5qGXGRrMhYEjJnjEhyf0Nr2sPAOX4MTcilGtf
 kXbe14oBwOL/GECtDdjngGZixojHyMUGZgkRHb/q3ijDYeLrPvL8pEClG/HPGS/21tt8
 sLNm4niESeGuDrq9CyLPQ2H6CK42CK/sqyUwlq2KQfX0ACZG63f9kPkWbBYjNyLwEtmP
 NG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371385; x=1793976185;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KbultFdxARc0+R6qwvP8HKFaCeHvN/9tHGKKeMncdgM=;
 b=u94RcfiafKPxRAhU9rgi9UWEWnZVZSadRLfO2aAYHK8bPDD6D6El/p9OfDi8X1aJ2B
 Qm7zkJSc/ZOnxhXx6ZW4g5FYzZGkKkaNLyZYAN21FHx1sDEe2qvGKVSFL7TlNgzMvSez
 mHm5AJghqmKjLgyWdQbkxh8NXnpYuKIrtKWkETqgSDDWbFzooqpGllLBP0bvaPyMIsjN
 H6CFA89h+js2SPPoB7LlWXctltEG9FlpTqt2/IIl7C+/2WEodXE3+dwhRJOScXs6DYsE
 UPzrjUZaY5dsyUTxs5KDpjRZBFfXiPhr3bTTUBYHrKpNuAsghFFAMOGNRQTTFuKeE2Gl
 EWSQ==
X-Gm-Message-State: AFq9FYJNlJw3VxEbOXZDOvlWL2bHHDMW0xK5qyJAaNn0dBeCAo0hLy7A
 WzPvTArgPiZVDDdh22G6MIrNBG6dBxaH/TlhlN+2vkRTDyYZWRFd7lwtPDz+qz7NcR8DVlKYC+h
 eP5EngzeXcACwaNzj5GGpJnXN6plMrE256n0oOuZ0w/mvWqnUMZHalL98Vsn7YCrrsrr763Nyn/
 LAmqKGFuF+CKgwlr2oBqbZ85JDv2kluWgAzyXhU+J6QJAebQ==
X-Gm-Gg: AYBFou2VyINezkYZx8skDuUy/q32be1tnZoipd3iepE+SYHL0Ow5ppHhGMIBnUDzEwf
 PVjRquIdGZ2+nUqBS4PSQBdG/6QDy6AV8Mf31kcMQMW77W5u4H5QVHJMC7/DuNpq8nKBVUVmp5m
 gHM5XyvQGEu5pjlYwuSurxSEC9RmSc/7M0iGv4E4VqbY78IB60sEo4s0KcEw==
X-Received: by 2002:a05:6871:3149:b0:4a7:4323:3fe1 with SMTP id
 586e51a60fabf-4a9075f9d96mr1670315fac.20.1793371385036; 
 Fri, 30 Oct 2026 07:43:05 -0700 (PDT)
X-Received: by 2002:a05:6871:3149:b0:4a7:4323:3fe1 with SMTP id
 586e51a60fabf-4a9075f9d96mr1670299fac.20.1793371384641; Fri, 30 Oct 2026
 07:43:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-14-robin.clark@oss.qualcomm.com>
 <b1bf792c-8571-417d-9c98-f0b330a3abf9@oss.qualcomm.com>
In-Reply-To: <b1bf792c-8571-417d-9c98-f0b330a3abf9@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 07:42:53 -0700
X-Gm-Features: AclHuK99uM--i8GzOCl9TFxS2xsZbwdUt-6JFVQBI-5UrBBF9foFWcKCI-hrO7g
Message-ID: <CACSVV00dx2kijKkL6-=GzQX4pw+1pK0MA-hyveCscVdDKy7w0g@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] drm/msm/a8xx: Add all CP_PROTECT_PIPE to pwrup
 reglist
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX+3OFw/GLTwSG
 DT1aWjQ7kKRDswnO2Cr7Cbo3VQIN8Mo7z29PRXuIbULFe6VQoFWr98dw6GTLAyr9Ul5pwg2oYb1
 0dKj5KMVa7tsoOY9lvW1Pjd2o54JneQ1gNWEVyD5pjXI/BG4JrXGhNVEM1oJWPJ42X9bqwQCArM
 cIXT48a6EXM7evu2yvFCuy9tuTEunoaYOaDNVlmvijZfom5Rb4W3yUo0WEvstekMciQMzJFhBQm
 YQl5CbGfkaTJP9C2SXIe77JKo/d7KiJM4rW1HkDkRgvC9wAJYy/DRcZ7hWXIacTPpxww3NcLZIg
 hqPFdZMUsLBnl5Fknl5PXWBVBl9eFrOBWKQXRbFvx7VLooRigxmhLfbYew3RRF2BeegPXkLAenm
 NDCoa+rdzkNfEMfK5LGHNXEgIGtzxn58eptik1iPCT78nl8SCedvAYkXza/1MoFK0uvaCdZbYoH
 7TwoBZlc0fipTMlSpBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX0SbexzBlRz38
 eV+ClM4O+RPzo+8fu6pGdWUUrozGXA2mNAKdGXleLiUbd9BzvTYS+vPMPnjqtK/71dNeUcTTJQ1
 G5EirLfR3WNteHVDO9V8dTqyNoNoB/s=
X-Proofpoint-ORIG-GUID: JWXPwaSp1sr5vOx8EQrLqYuOus1Ok8an
X-Proofpoint-GUID: JWXPwaSp1sr5vOx8EQrLqYuOus1Ok8an
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4acf9 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=XFQ3HDCW75CJcarWahIA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300058
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 6:46=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/29/26 9:16 PM, Rob Clark wrote:
> > We're going to start using more of the CP_PROTECT_PIPE regs.  Rather
> > than missing to restore one somewhere, just add them all to the pwrup
> > reglist.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
> I was kinda hoping we would iterate over them in the code instead
> anyway for this one

I think it is possible to generate these.. so the looping would be in py ;-=
)

It might be worth re-purposing the 'value' field in
adreno_reglist_pipe to be # of consecutive regs?  That would be a
straightforward way to compress the table on the generation side,
regardless of regs being an <array> or not.

For all the generated tables (esp. the snapshot tables) it would also
be nice to deduplicate identical tables.. either at generation time or
with the compiler.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

thx

BR,
-R
