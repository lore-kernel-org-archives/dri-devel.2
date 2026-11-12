Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E31606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=katy9RYF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3DE10EB3E;
	Thu, 12 Nov 2026 08:31:52 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 535AF10FC18
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:31:46 +0000 (UTC)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso4889155d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:31:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794472305; cv=none;
 d=google.com; s=arc-20260327;
 b=igOQGJx/vn6XVrk+sX5G15IeQoXRxHjhmZyGgX6GEFlsvyfJsFvfKxl6tfZkNmEeJv
 /Z8YJ5JqyQFj1GvGsuzHbPzd+hhjWlmpIxdRGejNlcxwEg0Zaa8xibl+LH2iNlgVYbPh
 HxmKg5XYP1MMv1fnpbTEClCcdwBdCEVOx58oi/taf9OdxYWA/liVfFf3OoTlF1v0QmT6
 Afb+2K8/OMu55aEF6bVmV/zHrY99DKdiWKCQGsOQ8pd8o60O1pEGPo9HCTaCNQNtNUu3
 O5L7Ly0UXJ4YGkQA1cqaPhdKNoEikAHKK5UHSYBQOKlg+CFB9euby1p8LVTYsiXj5P3T
 DnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dDoN/lAt0XISVjDE3JROfi6pDhcTMzVIBmoJNktRod0=;
 fh=USpnT1rN25DTIo7+3eL3dqo/F4NAQXN892fpZC8mAuQ=;
 b=iCwF2UCzBuJmL8NwrK+I2AE2KIoWho06DLQKHI2ETJ4teOmIlFm2XkmUh10wIHxU9Z
 c8MW2mfdT0amzI+VmNMjm7W+d3S8WZHN/yu+B6DcvP8O95Xf3dN8KtCovr5GhMI3Y09v
 8XaKSo15QgAc6hesa6JbVSkDoGzL/VT6+eGfQi4v1+BTnY+li+wXIXThz2pP783fMMlL
 +9tiCAaCa/3f1dkB0mRg4PwtDkpyU7egMku98tZy/YlXKhD4XkUBsVO2XiEIYJfbU9xs
 UlyvLvar/hPcDQLZVejqm3ttEEesL7r/4vJmQ3TcLo/8/DkyT+OnP/uCCzfTq1kMPKkJ
 3mYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794472305; x=1795077105; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dDoN/lAt0XISVjDE3JROfi6pDhcTMzVIBmoJNktRod0=;
 b=katy9RYF+L4i80jW4r2Vvse/zi3se357PPMUVbBd7IopLieaEf+lTuCAnLL54yriVW
 2UAFWxpHkME03HKYjDt6Acav6JOD1Pys3n5h2PEpb3VmyFpSFWgvfpkIZvXDOD3CFBTD
 ZUggzuorG1ew8AKLVUTgKUnV/5i4dtmRFbJbpzZ2R+Aeo6y7Az2gfNd7u6KUrsXH5Huo
 jCNZd64tMt7n78g2m4B01fYCIJmYbxTRv1VFFn1FEkYETmEetQw7rpepYBzCIp5p8jdp
 8Pjfjh2FimIE6PgayQs3ggCWJX0fRB09tKtxw+ldKt9nvxcrCR0kgs+GmMTSz0oezVt4
 xsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794472305; x=1795077105;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dDoN/lAt0XISVjDE3JROfi6pDhcTMzVIBmoJNktRod0=;
 b=gmOJ8NvrAyX6KwKz34OS2SZKRRjuKOlCDCWHJsR0Xsy+JucH2JcIQ7+na7fztw9s6+
 vphqSCVMqMvRrrlwJStEPOLQWmuWlNAHbIgaQyJvnbDgRT7IJI27c0af471HPZ301aI8
 084mpG0Pmc55qy72qyvZf3Tej+SOYccoCuz8YPGaPcaU8KJ1x6Opdah7/tdSXQJjFpXF
 yK69E5V6yA++OE0B23DELpoV9ccdtVpVRxvVkR41MNJzafSBQcws1I+d4CRwdtqE53W3
 eiJwAs7M1Txwz51S+e/GBoDxglQK3jd2mBRC2pbUnFJ8qos7qgHrOoqrlpp2zimOgt6n
 0EkA==
X-Forwarded-Encrypted: i=1;
 AL+hErE79oyw/VtVr2Eg/MFWMx+8CmNNvWkF8IsGVWstKjO4KLX2RNlDyqjvtxe23YjfAxTb4wa2lYwFkR4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Z0qST6atwV930lrXxiRIUj+A0SSN2sSPhCjCpoAkSJ9Ux5eqO
 jRgB0oS7hjfp3T7hMCqbjgHV6dvUhHXgiTOGRd063VpNlyFYHkJgV+u3jAYfgZFlcZDTTu3Uhto
 wl8AkhQeaYkzKiKHrLxxIBRQPTeUpT/TWiUhATNFFYNkgZMSDUao9upTN8w==
X-Gm-Gg: AYBFou3ExwvvYZXVD3OlhnyBkhwoevI180gtbFhPeGy6XgwYxnmHR0odDCinK1tW2jE
 P2UnQIqa0Ub4FY15myhZ6sdkri4x8O0eL72y9hYkhabUREwJEoLhmj/GanIlTn8NyoEcE7WBEYW
 jm5Mf5EIvPQglyIzStCfEckFrjwOAtcxWmxXdrfhHJrWh6mENFybN+/naXNIeUTD3cDHIfL+GVo
 7B5G3TEro6m/g9uxiPoTJxCnr8w51B6KphsLMtQFy6yr+BswErlquG9F+S9wE7aHSlpvjsVyVug
 XMPPUxTWGPHr0cDJqqqr5W9Mu2V6SfJ7IchECiuKQ7ozEOrBQSGoqUeil8Tp0E1tpE4bb3wK0nc
 vP2v0gio8vL/O8kWE0qja0Le7loee9Xrq6BNyoxZdmQ==
X-Received: by 2002:a05:690e:4854:10b0:67a:3a11:cf1e with SMTP id
 956f58d0204a3-67c67dd23a6mr2010175d50.7.1794472305113; Thu, 12 Nov 2026
 00:31:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
In-Reply-To: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 12 Nov 2026 16:31:33 +0800
X-Gm-Features: AclHuK_yCgsU2Q3_YXqrKmP99Rsllhkisqq8LiDMqSYcA-wB-d8VrImq6J8CDlA
Message-ID: <CABymUCNmJa+9tvTtnJ1jP8=_sFYKJ33ZkowjMwmLUYOsG4GKdg@mail.gmail.com>
Subject: Re: [PATCH 0/8] drm/msm/dpu: Support dual writeback for quad-pipe case
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Missed to add:

This patch set is prepared based on quad-pipe patch set:
https://www.mail-archive.com/freedreno@lists.freedesktop.org/msg47513.html
