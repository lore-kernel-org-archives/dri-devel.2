Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65896C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789AB10E9C7;
	Sun, 13 Sep 2026 20:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="if5scmlu";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CEA10E760
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 16:35:13 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so417123f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789230912; x=1789835712; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lyDyzwXLDdcuGlMTGZyNhCieQRVuG7gzmR1vCWknrTU=;
 b=if5scmluUvIoWXxWX1ZgfljOkh3HGBgdlw3lxcJCo912x9W6/FGmM4GXZ8cTb2gaOm
 EGkQD72xVR1jnf9c6PL9LM4+zPF4n9I0BAGVlGj98vsRxdhmQRgchD/0XxRAHMK9GEE8
 KikuLL4Re5j3uoKzlXjvowBqbeH/sg3Hyjm3zQi+pr8g415FSC8dl8koE6yxrgpgVm/R
 csHcfsugskVcwpUNIBzZhO13UrcPnS9L5zQNxNbcNxgpKpPdWBho56jTG605jljgBUxq
 lUSvA+ZRYMuNWYELR5FRXgqhMVB9XAMKCTRI8hRSdf4ly6b6m3zfyY2vE8todFkzTYej
 7baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789230912; x=1789835712;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lyDyzwXLDdcuGlMTGZyNhCieQRVuG7gzmR1vCWknrTU=;
 b=b2ML6E3bZ84oabExtMj34XUptAFQ4VO8ks1+a7XoZbW6A9hoakLOP9XxDVOV0nArPO
 KCWqfxxEiSvm8ODxpHl7uexO+bJQsVKZAAoxsH3L1Lkh1PVVeDko7IZejV3s83SoT3QS
 JtCRwgMdCsEFI+0GmZJTAUJaqPIBDPzH4/9DyGFH+Wt6hntqdO+Zg2lJimLSgq6ympZH
 fxZ+u8Lo7arVYJZHZAWqHkFVIcPpav0tlKQ+a9T96nVmhrHhho/sTglH9byendrAxgzj
 Wl95cjxM2iXhBU6VWJSVkpOaIUkW0BYy6iiBmAPraCttFQoEx8ITHqKMe3W2DwifNpwc
 jaew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPN0bbhpjnjpzMv5vc0bLBQCu9NIu3VhjNRcLahQtqBRFwZM2UnAEiYuf7l7sfEAMTpfL4+XyBr4o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lqSZarqdqdpOlJ1bINvWblJ468NbJIWd0NBryelexFU0+TQKwO
 KhVaRIJRc1wpCTkhWAw/j1P0qZX7BUp5KxJBoZAP38QaYg+ED8PbroP0
X-Gm-Gg: AYBFou34F7wCj3MnNtviEmFaMqeqXjHnGXFrK37aHjYaYQQlFD9toautvEXQ2EWb0HW
 bdKgg2DuFoainuykdpINz3JjCpvnB82MGmb5tp/wRtdbJvCZ0/QFpPt1uWEiUll4BBd2Z2AOO8v
 Jfcd2zO9DUL1ir4JQNrM6JDfJGQsdkkR8HzawNdbsIPVavbeW2ADFxHGw1cgZdn1Z9jH5voEY1n
 UG4krt0reEdMJrAmeBFHZRy1FxkUKyr/H1ps07UDKVwHx4ZBRSmNw6OZ0QUW4bB4RBrXbOAigQm
 XC7GLSj4b8USPujw/P8EX9A7sKzqY5g1CobqtrUYhL1yGnVQbpqiqeqhEYc7Zw45Ac8Z1W3fz2Q
 WUn7NqiH6MgyFuQYGY+F5SU2u8dbfFqYZohbnxaTiRdYOcEfazvySlnD+QE4DkQJBNC1NW9nn3l
 A8eM2PuKkUhCU4Fsx++E7Rhpv9vhpIRMHL4GRcguv2free9GXEQl0PRBaR6jnzLT+tNl0igXB+9
 0ZVQ7phE+7XO6tIe+tucuarQV1kngMHRAVbSKCadEXV216ELXN1Zy4ClYGo4Nw9r5G37+EbrGVm
 F9Bt74i333ajovH88k/24KtqdnWWKdTsnQEGScTMwbNO/Dqp1Dl8oPlz8pWXokiBQW6v08OIxYQ
 =
X-Received: by 2002:a05:6000:384:b0:486:e708:2e57 with SMTP id
 ffacd0b85a97d-486f6d4b39amr3108656f8f.39.1789230911707; 
 Sat, 12 Sep 2026 09:35:11 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de.
 [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e74esm13986020f8f.25.2026.09.12.09.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 09:35:11 -0700 (PDT)
Date: Sat, 12 Sep 2026 18:35:09 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, 
 Danilo Krummrich <dakr@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gem-dma: Correct GEM object wrapper documentation
Message-ID: <aqV-2xxp3Zy5IWqL@gmail.com>
References: <20260912063258.43169-1-kmehltretter@gmail.com>
 <20260912162516.GA1892234@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912162516.GA1892234@killaraus.ideasonboard.com>
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

On Sat, Sep 12, 2026 at 07:25:16PM +0100, Laurent Pinchart wrote:
> > Fixes: e580ea25c08d ("drm/cma-helper: Pass GEM CMA object in public interfaces")
> > Fixes: 05b1de51df07 ("drm/cma-helper: Export dedicated wrappers for GEM object functions")
> > Assisted-by: LLM
> 
> Throwing LLMs at this kind of things is neither a good use of computing
> resources nor a good use of maintainer time. Please refrain from doing
> so in the future.
> 

I view it differently but respect your wish for drm.

Thanks,
Karl
