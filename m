Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61FAC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5E710F400;
	Thu, 10 Sep 2026 10:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nvcE2aky";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6917A10E1D4
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:44:43 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso5198419a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 22:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789019083; x=1789623883; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vCsAiUiM0PKCV4ccyqUUSnv3id7jD+rmaY3eiA+jZJI=;
 b=nvcE2aky9DW23uUxEZnHCe5qlMA9dHbakD76Mmy5EfUen//JbYzN2XFef/LxXs/FFm
 cLYudgD6FX6mWcawYrvBdmquigVB6gSbz8pYsocRuNv/AW2m1lVasaOwtYgqpc++r03X
 4mzl+96/lA7E3r9qZvooWJhrLIp1v4ry1J8uafwLgJcUXAHQTykamdrcRQ/kSonZ7ox7
 RLN1DyzRfb2GO6zwfaBxaHQXSZeyT+HfWgfOoHrt9m/NPSqDXi1uAL79bdzYzD0F4k0q
 whoOqRfUmyI1oZZkeYkMdmF09lfVt+YDXNCWamNo35q7eG5oHHNqtcyg+QHVdiPcWz9/
 xuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789019083; x=1789623883;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vCsAiUiM0PKCV4ccyqUUSnv3id7jD+rmaY3eiA+jZJI=;
 b=M9/e7PU+45jJuMv/pBdA9yU6igQ6InpjnCMW0bRq/VadUe2rHG4IQoma6xuEoEzkf9
 83tX91LwNJUsnSqqK81ZEoYRKZ6PavPV+YAqJ8cvtnWuz2uO0DICAlMigr3ot3Rp5Oh1
 b2GQyhDsk0DwPHSmt9sk0YTWFQFCFsLCzpJUT8CkEOu9H0PSAPPIaqgu0aLzJrWgz3TG
 zOT3yDr+dPu5Tb8dNn3UsE1p3SpFKg01fXLt3fvl1gDnZYx1bW7H0ZlsYxvg2nMXJnVj
 xgDwK+Lk6SbwTwpGGt3CM8VdJthiGIrUVCAZzuAis8mbErF5pysPz8GH3qO2oHdQslE5
 3veg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5lByWUlAU2SExzblDIpTAQ7pTn5Df3R5F/3S1iBgY9pgUXgbxvyVtjRPo2iEM791JRzrMotQhsWE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktky3Ksm30pkFb/Ej/r+MKCg0Z0/5ksDOykDyXP7bQXb3nFL6s
 ufTlvhW0HsMxKY92KKIOKZvLLHEVjbLyLMLA8kqdXGoMNuK0kxIpjDzb
X-Gm-Gg: AYBFou1PyEOeQvjfOlejCYS3pFnkuChrUwdNXx0bZ0fTvO76iSlEyK2HfU+NZptweBW
 e36D8wLeBlVZysc1vZOXLmj68+evuTN/Ur9t7g8kJg97viEQkDZibYtiuKTROgnK9SjrvhYR4qt
 4sglDgK+f4pwm7fxhYDXFiwsiuflHG+bw9UK4TOrioE5kCfXo/I1cUdElYAI1n/VCMhv61Xz4CB
 lotCN3cxgJAXbKJwYmtNHy0HYCTBPlXi/Gv2K2ndz3JctbkojeE0hcq/lCmARHMzIswA94BDmQV
 vaiKR6vGclx+aaJvr6d0amDodOTxWAsRb3EpLCHUscUgDCS6w9P8vK2oHmD0WfgPwBEjMSIpLet
 7nE86Hol0dCDi3oqfabF+gPC/KR6+oPVYfp5Kr9yix+ZaIvSALf8KrzsU0+H9X9ELX2j96GFTQw
 Cm96w0cJq2nGZNRnjzY8XN2TmYx3sMJBDVedqwFKy7mtHZbs+yFIVrzDy9chxf1LOuhSX4HvNIo
 Py/
X-Received: by 2002:a05:6a21:7117:b0:3d8:5a37:549c with SMTP id
 adf61e73a8af0-3da39eb8acbmr70334644637.7.1789019082449; 
 Wed, 09 Sep 2026 22:44:42 -0700 (PDT)
Received: from [43.242.224.196] ([43.242.224.196])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3396e7e477csm17937942eec.29.2026.09.09.22.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 22:44:42 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: linusw@kernel.org, dri-devel@lists.freedesktop.org
Cc: leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 pimyn@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
Date: Thu, 10 Sep 2026 05:44:37 -0000
Message-ID: <178901907705.4155737.5974214979587698317@gmail.com>
In-Reply-To: <d3a928e0-0faa-4cd4-9d2e-cb9be4cf84c0@suse.de>
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <d3a928e0-0faa-4cd4-9d2e-cb9be4cf84c0@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

Hi Thomas,

You are right, there is no good reason for these formats to be here: the
hardware never looks at the alpha byte, and the ARGB/ABGR entries just
duplicate their X counterparts.

I will send a v2 that removes the alpha formats from the driver instead.

(Thanks Leandro for the review of v1; the approach changed in v2 so I have
dropped the tag.)
