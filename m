Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652C606A333
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ugl5bvoO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P1aQ7Bw4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE3B10E7F4;
	Sun,  8 Nov 2026 19:26:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A25F810E775
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 19:25:57 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A8Hof251769579
 for <dri-devel@lists.freedesktop.org>; Sun, 8 Nov 2026 19:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rvz+8jpHONGozfnXzrVmPZPB
 8+T67M6uMGo0MVWwUsE=; b=Ugl5bvoOuwlQXxrUrA71wfKTtmkNLftBCbXUUuAN
 QZ3eC1llxn8rk8MMN98SNoAZu90W38y6VxqbDnqJooqrVKkZ+SxXMvbsTAA3xK82
 QNk3kmY0knaQozYbR2bUA8Cdb0rZnRhfOtSkmTdj+MyTcBs8EGMjSy6vAJ1/I2Zo
 Vi4KUFXj7UeiJ99TpJZ94B15gNiH9zYKh4cfF4NcOIGuD7hJU43LeP8l11+MhMBD
 vBEpjU5CIDq8PbnKmcZprcQP1M+KK1E0Hp/1+wAbOgVRVK2E3PxpcKPimE8JlSCv
 Bm7PHEuJa0WzkR5qe2O7OPYecH9ZzSVq3zXrU/7ERlcDFg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsuagun0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 19:25:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91e7f61a26eso4641296d6.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 11:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794165956; x=1794770756;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rvz+8jpHONGozfnXzrVmPZPB8+T67M6uMGo0MVWwUsE=;
 b=P1aQ7Bw4LBAVLEJ7kXkPM8mEb2NBF5oAqpnmSC+Xh3Chn1QOf3eeS5zeAD5yKEpD8o
 X6O4cdOseaC2l3RdJSKo9zDe25aDAghMoQNdryLfOM/57i36dMHDWx8o0iAiqXcPkGKm
 hB0aL9BKzGrKkaBCNhYOsyjIDRbRMjYXb4H95V3N+xRQan8I//Fm/FdlcAnA/cFkW7dX
 +pnsc6J6tLqTZtCSwxBkQOzrJzCCog9vr83yan3wdqndD9eNSTRs929hlHzuz5Qbx7kf
 yZGlZBQC06nsuC4WE6+oGm3sbN2AkKPhgKZd2nyLONlASttBNmi0sO1VkjaTVWCGEuR3
 ZCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794165956; x=1794770756;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rvz+8jpHONGozfnXzrVmPZPB8+T67M6uMGo0MVWwUsE=;
 b=Kibsk6AoFan2UZ92zEv7QhbNChfqk1Nrij+3XfDliwNn/RoNEwjbBR3XghDJe0rQIw
 4Yn4hxU043dse6EKsLgVP6l4H4UH6t81og/pRYJFMUE22ZxNMpWI1CPj9RQkDGaqG8fo
 w8wgY28zgPlRHxSKYch/2G+QNzw9xIVKOS8WflsSmHGfFsgJYBQ8GXPV4vOmI8U4ztG8
 2DUKexkgMJMuCJau6dwmzJaJQ1AnnsFacJEbqLMyEtZnqdwmfKASyW6XUnmKsNYDa+Lk
 CzjfB0FMaK3zfxnwLPm4PdQfaX1GmpOESjnO5bmTbrQuTQ7BCldBYNUPuj5Ul2M5iKoc
 U0BQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEI0/fCrBm5zNVZhM2jMS1imJexnbmumjCxCd22ArlDZoFKcZFW+aYObeKz0LSQLJVAEIeDZ/B/49k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ISI0EtTwmtNVlAkQMxqfjkd5CbNS+aTDbfZSDVqGizXQObvqb
 4RkX4MpE6taSf+KoiF/qweSs1NNW7s2MHCaTWZ3ZTuRA4DIoa8DquG6TBwx1jFcrOt5mtAMjfQm
 NGh1r/JXzseMqnINGHnoYbKksKmi6AjBhejHd2913D9FHZGFlN/fq/+RbubZVB36HUKxaE/Q=
X-Gm-Gg: AYBFou0CghCSFIYufGclVe10Uc8xviKnvOmaue+5+GI9eBGTfFzppJpZGR6bR+oW9fH
 f+4Dsde4LMgWXWJIh09VuXnnEnpV1A29OK9e6KBP/bmaoJ6s2JwhNmEePucf1Ltcc10tklyg2JV
 PawhF7IKMiXMypUBABW7XCsBzJKiOBtgWkp9M99RhEOiZ3EYpsebHmcCMoh9/Cp/kn2r3UL5qEq
 pGbJk32ZW10hJ1tQbc10p7G058YBi9P6UbSW/ir6aHNfwZWXvE9/tOVV7w6yYDUU/QD6mOM/9qL
 gwrh+PiM5Ou2puv3WVkUxz93yhwgrCqP7i1WU755w3lAHxWGXFOR8Paowa4RyH6q69btROC8GUG
 LGg59j84jnQtgPF5877OD0P4fDAfgj1u9FA+5PewR6AV9TeRIuQ5MEhm1O7tnr9qP+4PfDAtFhF
 GI6DY0lQ4huhpSpzyFWiR/eo/Me8nM96oZfuFVO1hn8W2O3TTt/FdmKL5A0kV0
X-Received: by 2002:a05:620a:4804:b0:944:907:8f64 with SMTP id
 af79cd13be357-947842b26e8mr289433585a.67.1794165955818; 
 Sun, 08 Nov 2026 11:25:55 -0800 (PST)
X-Received: by 2002:a05:620a:4804:b0:944:907:8f64 with SMTP id
 af79cd13be357-947842b26e8mr289430085a.67.1794165955285; 
 Sun, 08 Nov 2026 11:25:55 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c14b81c9d2sm461073e87.68.2026.11.08.11.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:25:52 -0800 (PST)
Date: Sun, 8 Nov 2026 21:25:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Robert Meijers <linux@robert.meijers.dev>
Cc: yongxing.mou@oss.qualcomm.com, abhinav.kumar@linux.dev, airlied@gmail.com, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jesszhan0024@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lumag@kernel.org,
 marijn.suijten@somainline.org, quic_abhinavk@quicinc.com,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
 stable@vger.kernel.org
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
Message-ID: <vr7xot6mfkdjou3wy2ni33ctban7goaqsr3xuw73przuefaupp@6lexppuvjypx>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA3NyBTYWx0ZWRfX6Rk6/jId1xHq
 Iqiiwih81fyE6gQ/xnsj/KxEFB4YIHkDM48tl+duyC02cdCeHl1m7Ly/UYI3KALzqg12rI3wGBs
 1vi8fRedc+yVJ09p8rmP9cuwwr8BT5Ba6OT3Fm5LdJsrA9Z/ldN6VSG/1/9lBho7AQABRQhvM5O
 iD3DzNvXzfZPxE7YOmo4aNhvaggPoDklxtYNnTfVHSiJrlUytRX5jGCuK/a0/eRrT76vrXkiZVU
 72xqTgqKzz1USzqdIC6r21JTbRheIJ8/u+XTn43Z1NUMnBOoxoqN2pJRQPLhlEAnHIcH/6SAK2k
 C5EMuoZ7RO+8YH5YmF5+84W4bFYiv0DXXSf0oR0nbpeNfRxLpKtwEahdtmdNcoctNiuTa0hkIGr
 bxRrL7psk9HywAYsG4fzvOkyl11arMiGbj6XaqIMGeoPezxVm/MNUsBGY83wZNrnWdNsAtkHWrX
 A/L4U7hsQ26US04J8yQ==
X-Proofpoint-ORIG-GUID: UfbEiSBfFL9cReEwS3Mh3c_BmHt7jk9j
X-Proofpoint-GUID: UfbEiSBfFL9cReEwS3Mh3c_BmHt7jk9j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA3NyBTYWx0ZWRfX89a6lSvLxEbS
 Q4Eu6qEXd1uO0JGRQ4bFNLsrXSA+ODBRyoDp2RlgASGX7HLEGzfFFwmWu0xnrVsDc44IYs+nrfm
 RYBZHwKC27bKads1FasEGplGAE62s/M=
X-Authority-Analysis: v=2.4 cv=V8LoQuni c=1 sm=1 tr=0 ts=6af0ccc4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=ne830HvUTAimPEXBk1gA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080077
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:04:54PM +0100, Robert Meijers wrote:
> Hi,
> 
> ((Sorry, re-sending because the first was rejected for not being plain
> text))
> (First up this is the first time I'm participating on a mailing list,
> so sorry in advance if I'm doing something wrong).
> 
> > Add support for Multi-stream transport for MSM chipsets that allow > a
> > single instance of DP controller to send multiple streams. > >
> This series has been validated on sa8775p ride platform using multiple > MST
> dongles and also daisy chain method on both DP0 and DP1 upto 1080P. > > With
> 4x4K monitors, due to lack of layer mixers that combination will > not >
> work but this can be supported as well after some rework on the DPU > side.
> > > In addition, SST was re-validated with all these changes to ensure >
> there > were no regressions.
> I have applied this patch series onto a near mainline 7.3 tree for the
> Xiaomi Pad 6s Pro ("Sheng"), with SM8550. But with these patches
> applied I don't have working audio, over USB-C to my (DisplayPort)
> monitor, anymore. If I disable MST support on the monitor audio works
> again. Debugging (using AI) reveals that the DP0 Jack is not reported as
> connected anymore when connected to the monitor, with these patches
> applied and MST enabled on the monitor. As shown, for example, by
> amixer:
> 
> $ amixer -c 0 contents | grep -i -A8 -B3 -E 'hdmi|displayport|jack'
> numid=208,iface=CARD,name='DP0 Jack'
> ; type=BOOLEAN,access=r-------,values=1
> : values=off
> 
> With MST on the monitor disabled this outputs "values=on". The same is
> also reflected by "pactl list cards" and "pactl list sinks" where
> HDMI/DisplayPort is reported as "not available" with MST enabled (and
> "available" when disabling MST).
> 
> (Again, suggested by AI) I also checked the ELD, which in both
> cases (MST on and off on the monitor) is identical, including audio
> information (like "speakers [0x1] FL/FR"). (Also, audio works both using
> an AMD and an Intel based laptop, in which case I can also choose
> whether to use "HDMI" or "HDMI 2" to switch audio output between two
> monitors, in daisy chain).
> 
> So my foremost question is: should audio be supported in case of MST,
> after applying these patches? Or is this possibly out of scope?

I'd say, it was out of scope for now.

> For clarity I would also like to note that without these patches
> applied audio over DP does work as well, irrespective of MST being
> on or off on the monitor (obviously always running as SST because of
> missing kernel support). Which would make me believe that no audio
> support in the same setup might be considered a regression?

Technically you are right, it is a regression in your case.

Yongxing, how difficult would it be to support audio over the MST?

> 
> Note that I do understand that me running a forked kernel on a
> (by upstream) unsupported device might also lead to issues or require
> changes for the fork. And that if audio does work with MST then this is
> something the maintainers of the fork should, most likely, fix. But
> from the cover letter and commit messages it is unclear to me whether
> audio support should work and/or has been tested when MST is in use.
> 
> Kind regards,
> Robert
> 

-- 
With best wishes
Dmitry
