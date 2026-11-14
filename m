Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C9606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=hUOv+lsy;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=jjCMD/Mu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8F710E5AD;
	Sat, 14 Nov 2026 16:24:48 +0000 (UTC)
X-Greylist: delayed 382 seconds by postgrey-1.36 at gabe;
 Sat, 14 Nov 2026 11:23:35 UTC
Received: from e234-50.smtp-out.ap-northeast-1.amazonses.com
 (e234-50.smtp-out.ap-northeast-1.amazonses.com [23.251.234.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C716110E0FB;
 Sat, 14 Nov 2026 11:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
 d=brar.si; t=1794655031;
 h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
 bh=CV9YuyTwve6Y8x62zgH3MEcMQ6qnkYv+7s94JQgp7wU=;
 b=hUOv+lsyfZaVcewrBD2Ok0bzT0GvothMNhxL4jHrdprdr2reWiNXHV4VWJfR5sPF
 QD7O23vDuHzXvK0J+hA+ljElC+8QdGVhUe8hAidET12hGr/8iZSZte/tFAaCS5SzZS/
 IBwyPghumlpZgHSdoeWkjENNJe9GdgMo0fUoWBv0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1794655031;
 h=In-Reply-To:Message-ID:References:From:To:Cc:Subject:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
 bh=CV9YuyTwve6Y8x62zgH3MEcMQ6qnkYv+7s94JQgp7wU=;
 b=jjCMD/MuzB2rApZsLSqlw4wZmE6JEkfYhpdJI5VUoUS76ufWsrsjXTgGhgIt+aAn
 uwo5SGurRioPccWsGwnYMs3LW5QuF7TQBPpuuU6xC3LcTm32FwaotBZpC4VScYquxOj
 MZYUkFFi83jj6F4GT/5WlwWGuWsQzx+Nf09DTYpg=
In-Reply-To: <20261113-dpu-sm7250-v3-4-30bdec59d204@brar.si>
Message-ID: <010601a1d9c69050-ccbf5313-4751-4845-9ced-1076e0a55e3d-000000@ap-northeast-1.amazonses.com>
References: <20261113-dpu-sm7250-v3-0-30bdec59d204@brar.si>
 <20261113-dpu-sm7250-v3-4-30bdec59d204@brar.si>
X-Pmail-ID: <1794655030616.c0d97a04fb10@brar.si>
From: Ishu Brar <patches@brar.si>
To: krzk@kernel.org
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, 
 jesszhan0024@gmail.com, sean@poorly.run, 
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: display/msm: Add SM7250 MDSS
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 11:17:11 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.5YL5VvZ+qZ0e19wo5UdMspzrKjMAjMWs/SlfuwHJq77JVCQWpVGwyETo7FaXf+sztO4bYMxF6WHssrYHSY+K7X2T1EZhOskwm44pQQStdKG0Jdj3d5ybzIXFkMTcPBXllY63oWIrFhJN26LFqLzTuHiXuqj9UCHxIuFhxi7IM0GCfceBHtKocmWdFsR9dK9X:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.11.14-23.251.234.50
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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

Hi Krzysztof,

I forgot to carry your Reviewed-by from v2 [1]. Both =
dsi0_out and
dsi1_out endpoints are fixed in v3 as you asked, and the tag =
is in my
tree for the next revision. Sorry for the noise.

[1] https://lore.kernel.org/all/20261112-gifted-feathered-ermine-443bae@quo=
ll/

Thanks,
Ishu
