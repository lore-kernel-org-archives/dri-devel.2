Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09270CD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A54910E4A7;
	Tue, 26 May 2026 07:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GvVUP92l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eu/n9fqa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E5B10E4A7
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:07:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q4VesD004421
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UM8f/CGKAxyqlDwVFwOQ1tg0
 0UT1/J9JW1xp0T1vsJQ=; b=GvVUP92ld44qhIqwZgHZeEporlNAUJf7GOJl6TfT
 Plf8x36WeNGwL8yIz/JFTqMkJ3469Ph0VBqzaSaBqJsm2eEYFIUAWIlCgRxWLco8
 nkCYmOPw/qH0PeoFb5Tl3twUmx0T1QbcZpr+k7NOD7Vi7bVCECaP2Dh3br11Aspx
 rDvyMkMY3FhbPc9UAmGyP/vLrck4QGzGzY1tAmz72V8xxIxgWMyZqyuo8CNEsmcz
 +lvekAflYI3DBv4NA5LPxbOTP+l2l+wahW5dxheuVIoXx5BDovizpuMv0ZEOWaoK
 VSkfko7bMG2rNLRLe1xvLl3Vqr7bdNda6ynZe88wIdDcjA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecsm025sj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:07:01 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6312af70ad0so11014777137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 00:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779779220; x=1780384020;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UM8f/CGKAxyqlDwVFwOQ1tg00UT1/J9JW1xp0T1vsJQ=;
 b=eu/n9fqaPnTosJW0CKheBO87oXHqwsrjBVuYX83iNra3CjUwo6O//cMkNT40ebVxRG
 1htsCynlPsVNzMjPhVGixObvM/FeWdhXg6FEs3xfnXQP1rODYNNSY+iJR49Xc7QJgY7Q
 8BfW+OhG7nKkYoMu2nVX5UdNuWfZDk5sFFSJ1NJRLa3z1PqIKFEiHrpQRYqAVnKbJYUK
 2Te7ZpHS6+YtIiO4bL2YVJnvozVziXdHBWU6JNMs0P4ScurjWjKpOt02DDtuJA1DKIfQ
 jxFoVg2fVyRVVA4RpkKrmQrovyoqbwB9lsUr/Cy92WAwl9yKZ1VgShrLxgYJo08b9gTN
 L5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779779220; x=1780384020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UM8f/CGKAxyqlDwVFwOQ1tg00UT1/J9JW1xp0T1vsJQ=;
 b=M0Yr3v5ktHFeI0MKbizN5GzebPeHFdZ/3lLA8ewQyASuhK3xeKa/Qqpq1cF73n94Mn
 oKQu9Z1Rv31E8JZv1XFHQ6W5SsB83G2RIvlkPYqpmxO+Br21nGogyxcK+TH+HiL681lp
 A7Fmk5L68kls9x0Hcz1S5z5qAgMl8w0uhhRbpRy7ZeLeN+st2Qkv9+W4gsDQdew2FbvE
 y9ANaKokyqvsIfuX2Xm/+pgo5h3HBWYIOym+LUTGzOK4xUUTLJkm985HKFLBTUoK5OKD
 eS+95rsMphilI6zMoqz7yYRFJfpwRNr0UEILCIjSzr3PfsOCLJzSBFq4hsYyi7u/vm+g
 6lng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/yvlkOssJ4XVDpiFhcivi349KevxWXjXjw7gxBISjruYh0Ib6Wd3MZbaEj+YTT+Ivqo2xjtumdbI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWxPXBOw0/9MD1yKxSOHOQIYrTx9yjSRegKyitlWwkUriFVFWr
 fwRcYFFjOfTeEg7JDi40w22yhlZJmOmEElztwkDUF0Vcf6jrz9nvRDJ6zG29HxE+5lXQUyYfq+P
 3Me6XQreWgnwVxaMTwxjPiWBRjjL3uOiEOsuJMqDgJmdJrRlIQbAfqZF2x9Dx1qbi33l0F88=
X-Gm-Gg: Acq92OGmZemDwF0W52Uc5nmObOT4z+xfYhcPWhT5hEvPVtLk3O/oQBoXvKnX1ZfwfTC
 1W/jKmFQ9B2ZvGMeQ33ZB//rwAQRdK+CRKKrk1Q1PbTydn8puIi+y8X08XJUCFKSnPiKlNYzBtw
 Q8dnZ/HdZzYoMORfSZfFfdZaspZtxrfYdzfTkfjEDx3nFWw3JUYcfLkW0hdobogRYBzn6QKX5ln
 0d5bjYyOPZbIV8JQjUHwiVfEFMPaCtBc9mcpEg6ia9ijLQZNMML6Pqpi5f7k9Ni3LHfT2C0n/Hj
 OteEySxEM8R4Xi3Jvm1giPQUn3wAtzLk5yQAoXjyAufVDKb71H9BnIAmEsfwV/Oj+Bpl9CFa4+X
 09NKxZIcXFppTimfUNaHXTAuRDDQVp4oq+NHjIKdlYvhO4hTXXgK+/TlrnT+FMNID1dNXQiftya
 kt/Cdy5p3ifgWg5hOKNq6L+o6Z/pOLde3Rfl0=
X-Received: by 2002:a05:6102:3ec6:b0:631:26f6:7021 with SMTP id
 ada2fe7eead31-67c8ef49f8emr8748808137.26.1779779220668; 
 Tue, 26 May 2026 00:07:00 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec6:b0:631:26f6:7021 with SMTP id
 ada2fe7eead31-67c8ef49f8emr8748797137.26.1779779220261; 
 Tue, 26 May 2026 00:07:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa46322385sm231485e87.54.2026.05.26.00.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 00:06:58 -0700 (PDT)
Date: Tue, 26 May 2026 10:06:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
Message-ID: <osegqij5pitd7fjgpbslddbqgbz7lqrsjoneyep6izwu3kynhx@afvrjqpib7bh>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
 <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
 <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
 <lvfwkplrktjldbvn3j3jqh7ds25prx723at5t5oobsvhgolngs@pme6jiac5xdg>
 <85c2bfd1-8e69-47e4-a360-10a2655bd43f@oss.qualcomm.com>
 <CAO9ioeUgeo-MiP7pNY16wL9d7LKEi7PR7pJtH=1hMg-mnMSOPQ@mail.gmail.com>
 <4dc05557-ab95-468f-b972-84fe9fa3cc51@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc05557-ab95-468f-b972-84fe9fa3cc51@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CLEamxrD c=1 sm=1 tr=0 ts=6a154695 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=iAK14jTOHvnPAZLYtCMA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: pdEQd83JOikoTMU09IzPQUdLFSrnqYv2
X-Proofpoint-ORIG-GUID: pdEQd83JOikoTMU09IzPQUdLFSrnqYv2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA2MCBTYWx0ZWRfXwV5D+WmCHXYW
 GmHsqUS0/LorIXFkPq8fdzDszQNr0s2ow9vziVbBeqCFkqEJ2Ws/1F4pZKSPi6S9fUWR2EFXhYy
 pU42BOMOgwi+FBF/tdLwKyWKP5n9Y5OeJjK41HjAIwmWEq5gZ0OrSIfsf4iSFAUYzwauR21W3+D
 aZCBwdNEKuuzMW8IIEbtlUP0BGXLkdfrMGqcwzoJ/FACWWJlCiHtKo5dsrdgP8AV4d6iBEdf+y1
 h0YFeVlA2fFhGnfiXiUYaCHCltvQvdu22iWCTn0p53AVFjI0MvZV+l0SlnDiFyGXj1t18Uy4N6q
 Sgu4DcptrLqgLakT1QHYbR+RF60hiIPfAhLQXuOhAb6ZqdSO5CZUYUigYEjs3aQSVwK7WLUEdKJ
 W2WZqyfMqpNqtqhkyvtssIybdLlhIY2WFbxQgA2F291RG+HHWaLsGYRTnlH2jXTW/n7tJHWLyBD
 /NJrWBUsiWprGYQnfUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260060
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

On Tue, May 26, 2026 at 02:59:31PM +0800, Jianping Li wrote:
> 
> On 5/25/2026 5:35 PM, Dmitry Baryshkov wrote:
> > On Mon, 25 May 2026 at 11:34, Jianping Li <jianping.li@oss.qualcomm.com> wrote:
> > > 
> > > On 5/25/2026 4:30 PM, Dmitry Baryshkov wrote:
> > > > On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
> > > > > On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
> > > > > > On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
> > > > > > > From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
> > > > > > > 
> > > > > > > fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
> > > > > > > getting removed from the list after it is unmapped from DSP. This can
> > > > > > > create potential race conditions if any other thread removes the entry
> > > > > > > from list while unmap operation is ongoing. Remove the entry before
> > > > > > How can it remove the entry from the list?
> > > > > Multiple threads sharing the same file descriptor may invoke unmap concurrently.
> > > > => commit message
> > > > 
> > > > > > > @@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
> > > > > > >                     return -EINVAL;
> > > > > > >             }
> > > > > > > -  return fastrpc_req_munmap_impl(fl, buf);
> > > > > > > +  err = fastrpc_req_munmap_impl(fl, buf);
> > > > > > > +  if (err) {
> > > > > > > +          spin_lock(&fl->lock);
> > > > > > > +          list_add_tail(&buf->node, &fl->mmaps);
> > > > > > > +          spin_unlock(&fl->lock);
> > > > > > > +  }
> > > > > > Is it expected that userspace tries to unmap it again? Or why is it
> > > > > > being added to the list?
> > > > > User process can call unmap and fastrpc library won't call the unmap again.
> > > > In the other email you wrote that the driver can be used by random apps.
> > > > So... what happens if userspace unmaps it again? What if the userspace
> > > > _doesn't_ unmap it (although you've just readded it back)?
> > > If the same buf is unmapped again, because it has already been added back to the list, the unmap logic will be executed again.
> > > If userspace no longer performs unmap, the driver will not unmap it proactively.
> > > The Fastrpc driver will free up this list during fastrpc user-free.
> > It will free the list. But what happens with the memory mapping?
> 
> When device release is called, DSP side PD is also cleaned up, which includes cleaning up of DSP side mappings
> 
> Before kref_put of fl, we call DSP process release, where DSP PD is cleaned up.
> 
> After calling this, we go ahead and do buf_free of the list

Okay, capture this discussion in the commit message.

> 
> Thanks,
> Jianping.
> 
> > 
> > > > > Fastrpc driver will free up this list during fastrpc user-free.
> > 
> > 

-- 
With best wishes
Dmitry
