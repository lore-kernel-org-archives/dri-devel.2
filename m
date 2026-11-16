Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEC606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M50df8H1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5587210E3D7;
	Mon, 16 Nov 2026 14:02:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE21F10E2D6;
 Mon, 16 Nov 2026 14:02:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86E8E43A47;
 Mon, 16 Nov 2026 14:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86321F000C6;
 Mon, 16 Nov 2026 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837751;
 bh=yMd7BM9ItioQtJ8JDmysZxycKCnIvgPLTsTjZtr0lQM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=M50df8H1+IuNdwGGw+m4zdCkKlUaaZELq7jaVwViJuxfOmEkaPmzu/WQG3vShf/q+
 9gpyeR/oqmMZDDZcuAb3gNj7vfcHzv6CfJ46845H7r5JpnuRx0GO9vdt7T/lYM+niv
 eZS6KCP0UYIa+W/K6TLzdU435867pvc3myAvMsj6mTMXvmdYbaAbSQSOdmBKPAHyMQ
 I9z0gxcqLzBF6bkAso6NN8RNXCHcztgyg8H3hIXhTea4BYk51wxJmnxb6PANTR+q+V
 acbHgUhSi7d42fpMHJE3xMHCioayRwpPZ/uHaWIPOVVxmxo2JSudrrIDz9FFge4vET
 zpvB8UXRQE0Fg==
Message-ID: <aab9b58f-d7ef-40c0-a6a9-74a6c749652a@kernel.org>
Date: Mon, 16 Nov 2026 08:02:25 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] drm/amd/display: Render the panel power savings
 kernel-doc
Content-Language: en-US
To: hugo@hsal.es, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Ray Wu <ray.wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 David Weber <weber.aulendorf@gmail.com>,
 Shivam Kalra <shivamkalra98@zohomail.in>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
 <20261116-abm-sysfs-commit-v3-1-7a3d84a5328e@hsal.es>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261116-abm-sysfs-commit-v3-1-7a3d84a5328e@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 08:01, Hugo Sales via B4 Relay wrote:
> From: Hugo Sales <hugo@hsal.es>
> 
> The DOC section for the panel_power_savings sysfs file is not included
> in any rst file, so it never shows up in the built documentation. Add it
> to the Display Properties section next to the 'adaptive backlight
> modulation' property it interacts with
> 
> Signed-off-by: Hugo Sales <hugo@hsal.es>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   Documentation/gpu/amdgpu/display/display-manager.rst | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Documentation/gpu/amdgpu/display/display-manager.rst
> index f6de9e7779e29..ca4a956d2aa17 100644
> --- a/Documentation/gpu/amdgpu/display/display-manager.rst
> +++ b/Documentation/gpu/amdgpu/display/display-manager.rst
> @@ -187,3 +187,6 @@ Display Properties
>   
>   .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>      :doc: property for adaptive backlight modulation
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +   :doc: panel power savings
> 

