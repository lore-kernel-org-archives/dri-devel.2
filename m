Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1893606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBcR7j1F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0353510F2CF;
	Tue, 27 Oct 2026 08:36:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F199010F2CE;
 Tue, 27 Oct 2026 08:36:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 990B86021D;
 Tue, 27 Oct 2026 08:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834BB1F01829;
 Tue, 27 Oct 2026 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793090188;
 bh=X/TCTtmJ1Uzn5cvfiOwwzPpQbQnX/9Cz28E3PbzDHHY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eBcR7j1FD8ZaPwOuxYVo7OHZISHaGCd6CdfIIh+SeoVK7QVM8uz+OtByok/4en1fY
 /yLqrqaGdkmjoNF2/HFSNo0DnSHcO1F8kRVQw3JjL34VL8e8B3RP3Q6q0DbXA85u4x
 o9Q0NwE6yJWlMJFaBB0PWfZpncktejqmVrgRYsD7+ba3uH7mfk0ioEQ5EQ4F93zHfE
 ECK8DmCDu3KiunY9J2DmcxeiSdhc8oI18ZssGODYeR0Bf5IaCBVLlaFh8tNOH2Gmw6
 ep/mM8k3VrrOSou04acoslWgWNsM7zb3DmVDcw2Btq94emsEwe/ZYYnqmqKkJWChk0
 8OZRF4yC4ZNBA==
Date: Tue, 27 Oct 2026 09:36:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, 
 virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
Message-ID: <20261027-camouflaged-orca-of-debate-316694@quoll>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
> DCP platforms place the display pipeline under firmware control, so Linux

What is a DCP platform?

> cannot discover display resources through direct register access. The DRM
> driver therefore needs device-tree descriptions of the Qualcomm transport
> wrapper, display topology, IOMMU contexts, and panel connections.
> 
> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
> subsystem. Document the IPCC power-notify resources, transport and
> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
> after the IPCC power-notify sequence has completed.

It's still DT for real hardware, so I wonder why no SoC specific
compatibles were used.

Best regards,
Krzysztof

