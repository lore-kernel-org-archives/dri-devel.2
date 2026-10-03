Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD70ECA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A49B10EAEA;
	Sun,  4 Oct 2026 17:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AGKpocnz";
	dkim-atps=neutral
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D9C10E155
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 21:15:36 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5bc18f54abbso502407e87.1
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791062134; x=1791666934; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:subject:references:cc:to:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sYdrKmlcH/gFo4xN8pAi8w6DeNulYqQ/HX5EWjKFQ5k=;
 b=AGKpocnzg8hruRXB1cU/R1uIoT1E7H99XqEzETrRxKceSAgmfXEx/hIJbXN3yANie+
 +mjr3NHuJOoo41nIzC7vH9jtlnXBxc8HUHae3qY6XVxN54rrHKtkv+hYxwcRShmdHLZa
 ogoWaH93u82vArs1/MjGhyjoc/GmAYISj5g9vgOjKpJv1BsUy2EAGYIKtxmgHXmWQ3oz
 eu3SVkRIVYqdJ43vFFp1ozYBASn/mR5JB02JCPAZDaHzGWzGsj8OAhTHWcKL0oiXfLG3
 nyqWhLLHoKBNLF2sH/qYKYtZXAnGgcje05z4lPSaWPY5A86rRRH9+70/qpvdov0rqLXs
 a/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791062134; x=1791666934;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:subject:references:cc:to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sYdrKmlcH/gFo4xN8pAi8w6DeNulYqQ/HX5EWjKFQ5k=;
 b=XQaVsiXJv7IMBljMKjE/hmOzLz/vh4xj5+SfjYK962oVcouvN0KHC6SAKF7kao4U9m
 Wq8vzA7Nc7yfHsH6W9cPzCsWqgD1xTD+uMAB3ipQ3kuuS1JScgksI9HrGsNYyrWGBupj
 djZ3lLMR9ulnDwCCECCDdGXCsbwiwyzxuMghjvlCaRug1xD24Y2LA2d2heQBCWYkye38
 nDn8WC75ch+xs+fa2wXLx4DJNv0m1lUMEHua4cjdIZ8osga+6ZnBnX9oI3OzN1Fd6yEy
 wVD0bN5iIzgOnMzBQE0WIPQ60IrsR66Y8/ZbPR17xKDUQellGUuRLg9VGDp2eHGN2dgK
 fPmg==
X-Forwarded-Encrypted: i=1;
 AKwUvByV4/Ezag4psrKTS0xmNJg5OvRuVQ6LHhHjeYcwIqrFxQuDV8uVxftRHOFQRswJXlfoTzjaKpCk4uk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI84yXwtiHchYEiHlv7Q/Ox3zrcRuhIWZLOTSTiiSMwy5SOQtXx
 /y5D11J513sTMbsg/aJ3dH9gMLZe0AAJkMm/0ESfgPriT3RbmwoJSt3T
X-Gm-Gg: AYBFou1n5WL+oUa39Y1c54Z3SsK5sDpp+1HbbqyI8Fwwjjh/Z79ppXqJaUxvA/duw27
 tBlL7Ay4Q9NMqBdTV/oNtQgBHoAovEKdq/dYT+D4tOofe9Amo4XPupOPMqcXV9gY9BzLbcnFmb0
 L8AkyOEEshSQINQ9BbE5i/75zpdPPsc2vLoSeA01yRx7BfrhvoUna2dnAQWD8Ca/41I4OlVo4+g
 YN+txMLF9HCKFqBBVu6cgI6qOLWaWQ1U/eVevIu8twD6pIzquAJnNvCFHUqTLRXSYCyaLIsfwn5
 ZE25mmhUFSC/zyPcRdxvRcin9UJAwnPSgACcX2x/hj+KhN2U2RS/RGJG1JXZ8TiO9bDlo2+kXb5
 FOLfprF7IWJKSnEEoS23Si9N23iA3RGvz0qLSUldDdkjYY/1EWWzID3AbO9KtO6AmgR3EkECDCb
 vcZG4mDl2vFIDYW9UQ5Tz92CZYqvyxHdRerj+JCRrrXrEPDoUFaa0trt3KFA02G6Wn4OErPUJ8J
 fEvAKYr4iQNk6xocd4CTbXEd5+EL4lIZ+SnJHp7A6AZTw5Kfr23LZaRyw==
X-Received: by 2002:a05:6512:61c4:10b0:5b9:6603:d45f with SMTP id
 2adb3069b0e04-5bcb546bf56mr840472e87.55.1791062134218; 
 Sat, 03 Oct 2026 14:15:34 -0700 (PDT)
Received: from [192.168.1.152] (95-27-153-35.broadband.corbina.ru.
 [95.27.153.35]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c79dac1sm1820978e87.47.2026.10.03.14.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 14:15:33 -0700 (PDT)
Message-ID: <cee107e7-b747-488a-bc80-e0d99e9238ee@gmail.com>
Date: Sun, 4 Oct 2026 00:15:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dmitry.baryshkov@oss.qualcomm.com
Cc: abhinav.kumar@linux.dev, airlied@gmail.com, akhilpo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jesszhan0024@gmail.com, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, marijn.suijten@somainline.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch
References: <20260930-adreno-progress-v2-3-3882f0fcd7b4@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] drm/msm/a5xx: Add hangcheck progress detection
Content-Language: ru-RU, en-US
From: Nickolay Goppen <goppennick2004@gmail.com>
In-Reply-To: <20260930-adreno-progress-v2-3-3882f0fcd7b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

Didn't solved hangs on sdm660, but I think that it isn't related to 
this. However I've managed to get a command stream from hang_rd. How can 
I share it?

