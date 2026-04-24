Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A387FED3EF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D8410E2E5;
	Fri, 24 Apr 2026 17:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tivwy6zz";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E556910E2E5
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 17:17:41 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso11060480a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777051058; x=1777655858;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FW6g0bJit0od004CvbQeY7PjI2hNQbQHIakbCaldvdY=;
 b=Tivwy6zzbUt8BRyOq5lTfIBXy9vk4+cP6HRD42lCbvXPRXoFrIcINQ7UK6Fu68hR1g
 k3/1tYEjxlk+bCH4Fanfd0G00Se+X3lO9UfnkqUWnkUkVRk90BqfilJz7oPYSC+ioSWc
 FMuCPnzDe/n7+Z8IIs0DIr7M00KzwKeoa5JJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777051058; x=1777655858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FW6g0bJit0od004CvbQeY7PjI2hNQbQHIakbCaldvdY=;
 b=IchGQJxJwlF/nUhuW9epMI1S9e+fQewXXlR8tcquCWeDt+8VpGUgCuIuk0wxoK8RfO
 3glpxAsWcMucaimhbKP8bi4RFf1fLe3XNvAoXGKrnaIAIIC76ZOJWqHr7LlYwWvEGVLm
 f+Oj7QjPvI8AiysmDMwQbryFXQqMvtlUqeM7k7QLd6Ku3AFiayiVCsp3jDrkslh5JCnB
 kFVxdUWqw43crF9NvbCl81FhGbZwJh45YtjrQURNa9RQmhcD0xwM910J0jJ7ZMlVGDhd
 7Z7RM6EhHoQQTnOPsQe19TCztukOr86qKLnrb++aerT2DeXU36qzxhKXBbYbT+yLVhGD
 DrVQ==
X-Gm-Message-State: AOJu0YwKerg3NduK3zkZ4AAQ2nbPcEWFJlYUgtXg/L6LNmEIA1NNOi16
 0MyeuOfn5C4VhA3jr6G60dgUfxMXO5VfFekZtNeoYPa5Y/NtNMaKFk/1c8MT6iRlKwl4XrgU8wh
 OearrQQ==
X-Gm-Gg: AeBDiesJV+LoszXI4/9HcKb01R5g5ms1Yd5Ae36jvVqxo8rJI0F4Gn+fm89yWn1wJ69
 VidznNNUei1uOfxDujYAJQuSmMBuk0i8PY1B0VLbx/mN5RSLwwmESVhjkTedTI8MENhQaX3frEy
 0Czj7VWQdIEQlpChuBZuxyTga/0qGiRiMFusRG4g4Lb0fKd91ZnG/KjPCE5pmBlto4ujL3C/+R1
 YeFWcFL5yfevleZCp48HtJqJqucOMDV2WF1M/vrC4iuolHhCJnRirGgOx/gpxhyoBnt0lh9n1Rb
 DGI01HQMHhouJqbMxHcFEN81H1Bs76J3r+pYfeOCD6J+P9WBnS+6UtRdyIvQZFt97ixSIRZQHr6
 IRIx8iDqO2sOcMcGRLstLMpvuyJB8fz62vYZ2slpBy5gcQJObwkodkb8KNmwOAvY/1I8lIohE/N
 KkWci9Q7ayWfzn+Bk1fPUqiGq23kiSCLUpzDeJ6L9djPshndHJuWCT2zNlNT5s7cy0Hn8EqLrH5
 yzM78e3ztY=
X-Received: by 2002:a17:907:3f1c:b0:ba7:670b:f076 with SMTP id
 a640c23a62f3a-ba7670bf31dmr1311973466b.2.1777051058281; 
 Fri, 24 Apr 2026 10:17:38 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com.
 [209.85.221.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba451210e26sm808494966b.8.2026.04.24.10.17.36
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 10:17:37 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so4242127f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:17:36 -0700 (PDT)
X-Received: by 2002:a5d:5f92:0:b0:43d:71f4:7ed5 with SMTP id
 ffacd0b85a97d-43fe3dc54famr52344267f8f.17.1777051056156; Fri, 24 Apr 2026
 10:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260417061842.66631-1-avinal.xlvii@gmail.com>
 <20260417061842.66631-2-avinal.xlvii@gmail.com>
In-Reply-To: <20260417061842.66631-2-avinal.xlvii@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Apr 2026 10:17:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkhoCrFORmYCK3frspXtzsqbT4fRzSTZftecNPetBx4Q@mail.gmail.com>
X-Gm-Features: AQROBzA92-gfhVol4UOebRMLiIVqKfKOgHWY-G3zeE5POK5K7Xrf9S3qOXSa_LA
Message-ID: <CAD=FV=UkhoCrFORmYCK3frspXtzsqbT4fRzSTZftecNPetBx4Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] drm/mipi-dsi: add
 mipi_dsi_shutdown_peripheral_multi
To: Avinal Kumar <avinal.xlvii@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 neil.armstrong@linaro.org, lumag@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Thu, Apr 16, 2026 at 11:19=E2=80=AFPM Avinal Kumar <avinal.xlvii@gmail.c=
om> wrote:
>
> Add mipi_dsi_shutdown_peripheral_multi function and mark
> mipi_dsi_shutdown_peripheral function as deprecated.
>
> Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 28 ++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     |  1 +
>  2 files changed, 29 insertions(+)

Pushed to drm-misc-next:

[1/2] drm/mipi-dsi: add mipi_dsi_shutdown_peripheral_multi
      commit: ac7e1a9819d6ada9a9800d6d26256e5258711b99
