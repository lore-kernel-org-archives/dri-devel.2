Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF2FCD6E45
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 18:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B9610F4FC;
	Thu, 28 May 2026 18:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RzOTL3a2";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112CE10F1A7
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:34:54 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-841f52ce0bbso217859b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779975293; x=1780580093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yzn0YhLzTvt6pUfo05dJeo7r83ZFgX9EtU8J8f4Da+I=;
 b=RzOTL3a2msx5AujnyePz69OIpcyeNV8xnFRmloGc2xTRcbR06ZnuMPbGb43I4wG2El
 pg9QVR8OEp8rMKf2sX4ZpzFuFl9INLaRTPh4DXLH+TrFOzhZ4Mie7Hxyo3BYlyywGtuP
 0g/DqYIXwdPW+yKnSjH2Wwfnoihwe5pm9G1/4NrJw0TwNoq+ywVDtEu2hHqnQlG0pXiY
 C9Dv+8EX5dgRM9aQrWPOuQeBfFw/rlWoEcGtf12mS9HQx+1rh7chgqLkCSwv3UMFgxts
 7HsC0+ANCHdsNhYlz0YSzfzqEI61VOoHqpn6HACXCts7JfFoNdaZfHOteEAskrB5IAhq
 Pc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975293; x=1780580093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yzn0YhLzTvt6pUfo05dJeo7r83ZFgX9EtU8J8f4Da+I=;
 b=p2K17JkJfQh35Ud3ltfzXc4o30B9f5kte5r8hmgchaTWTkbnLLSUY8s/9xRdUxMwj2
 9vgHGYyEyt+sA2sZi6TOjULV3YOT9cijRqwFSaMaNZGKmfCBp7ooJiaL1YrUQTLigeml
 9dRXw1TLuEAaCNbYYaqAViwILi/eptmwGziwGx+uYNQkmfpwyQAWPYasQlYFan3l8cIz
 VKVq5JWIg9Q1ifwsV4hHsGGTSYOyfmx1iqy7APovASJ41BXNUaSivR89RUxPhkLoUkHE
 RiRr0Vy/FHYYTyvPBAIYZ38A4Afiqs9FZqzYDrLy4rbO5LUL/o0iadNZwUXkQlELaJzF
 3F3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GvrXlH1WwlFepbnWAlpylbQAOtAO1ChsI8ZJ/iVdBO+KfgBh0zF28Gk6MFEg1MnmgBs9WjMtyDlE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuDZW2G6MkTxDyyKUu5wOVDLYl2jeB8kw4DDiUmsOHbbbBKd8N
 GE79fSs/7sMds88lsDkXHrrHQ6IlFt4VvXKZGtmiJXuZH0iNbm97H/L9
X-Gm-Gg: Acq92OFkOEArWgpwxWJX4F6H+8DipctkwTkt+CPuKL14lI68bxceAtOiIxMVJZQjpr+
 xVtPq0l90SsPOHw2KZKGrGgIHTC4Fr1IbV4psmXIFUrmm1PUuk6OcqwFwIqvq7y3i2dRujNGnJ4
 waeqPhud0l33YmJ44p1Rm1bKryWzLwAp3tZfG9ZoYUMTn+80YUUWctQ4LQ8UX0t3sMvaC5BL1Pz
 qEQo+SGW5z/UcrK1kodPgD7C1UKIc0O10Bnr00dMkT9XrShstYnT+kdTZq6X6ab3DMtAWstwect
 noVRfEslydd9xF9dGdoHeNw6T3uoFr7DmWr2EHa4qIbszB3visEaf1ihcwLNJ+c3Cltwc70IFJt
 IhCt9GrmrY9d4qted80UEaRFYsrvDb0Cfg/iXsBw6o6az17OiUSMEwID2Uw1z0nfXYLhvurUmpo
 UEvN0yc4QsQErDsbYCBqw+7HsLVqJLwlDQvPfFsBT3UkwN05uPjEwD/MYDCaXRRqUWzdZTHThzQ
 IIOPEo+VG6xDz1o4GlByNGf
X-Received: by 2002:a05:6a00:3910:b0:82a:5ef0:210b with SMTP id
 d2e1a72fcca58-8415f15a77bmr25792188b3a.15.1779975293490; 
 Thu, 28 May 2026 06:34:53 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.lan
 ([58.164.4.185]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d6e82323sm5195429b3a.2.2026.05.28.06.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:34:52 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: airlied@gmail.com, andersson@kernel.org, bentiss@kernel.org,
 conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org,
 dianders@chromium.org, dri-devel@lists.freedesktop.org, hansg@kernel.org,
 herbert@gondor.apana.org.au, jesszhan0024@gmail.com, jikos@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, luzmaximilian@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, platform-driver-x86@vger.kernel.org,
 robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2 3/7] platform/surface: SAM: Add support for Surface Pro
 12in
Date: Thu, 28 May 2026 23:33:47 +1000
Message-ID: <20260528133353.33312-1-harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6808166a-423c-c801-497a-ed95cccc8d0c@linux.intel.com>
References: <6808166a-423c-c801-497a-ed95cccc8d0c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 18:02:26 +0000
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

On Thu, 28 May 2026, Ilpo Järvinen wrote:
> Could you please confirm this penstash is correct (sam vs kip)?
>
> Sashiko suggested it might be wrong but take it's report with a grain of
> salt, it's AI after all and sometimes seems to extrapolate about HW to a
> sibling HW without any real knowledge:

Sam is correct here, unlike the surface pro 11, 
The pen stash is on the reverse of the screen,
not on the detachable keyboard.

An image of the pen stash in use is available here:
https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/B04-Surface-Pro-12-inch-1Ed-Family-Rear?wid=1200&hei=900&qlt=90&bgc=F2F2F2F2&fmt=jpg

When using the above config,
pen stash events can be seen with evtest.

Thanks,
Harrison
