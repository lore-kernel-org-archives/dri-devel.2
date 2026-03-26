Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E83106F2E8
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E66C10E8F2;
	Thu, 26 Mar 2026 07:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MFw5Y1t5";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A225810E8F2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 07:58:40 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso463312f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774511919; x=1775116719; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hJidR7QlZb7c5WIdyj3iesak/Jfa6pt2GqscpVScNO0=;
 b=MFw5Y1t55SHroix3FJUqI3xSrQ6F58Y2o0ofwJmMl618DnnlivIoIvU6cT+YxfeFI3
 /WjsBKHa8Tm8Rp/C/ClYX0fmk46K0mFLZf8dy3+mLQVz4+IAiGjupIZyrdBFMX60CoU8
 2o/LOH94QDc2MD7U+JgQuBeVChXseRqeUEzUjEvDCc8r8DHnKSh037VqstjsfXPjTdA8
 J+Ajf+93pJ2qtxhWSCs1hH99kZbRzExXfB+C//FCVKIidp7BAg0Z9GXrE1IdvlD2x02n
 2vkVz5JjpNrHEKqS7SrzXV8JyOkPbu9MtcHSM8AWz5cjFSsQOmtO2O/ugOm5j5dZN2Fn
 02ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774511919; x=1775116719;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJidR7QlZb7c5WIdyj3iesak/Jfa6pt2GqscpVScNO0=;
 b=XIHNhY8sUskiw2E9KhcB0lA6QEA2ACwV8osO+1HJRnGuJ9FbbOFju5DeECjdkWcw+Q
 bcRWDX1iCHDcZgs+4unqLZjT2TRcK/X6uHmv3ZrSYzLPA5Ee306oTuqmgwUadyXq2g+L
 kAT4OmsxtR9jL810AgHg/Rq2ktu9YZ6UGKkU2WPF2AUcQJ58KxFPcyqLHMnZXB4pOpOV
 z1RRs3BljVuS0kU2r6jGBBXL1PlOzSbvTsoM6pRts1WNrNP/IBjmhYFLh9Hvrber/0Ly
 /SKEiAg3NYb1srXMfzdSy7k3R/iq7CAdl7U5fPuaWoIL1c4xcpY8p/1cT7W2ruSObQCO
 THBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGExon+SIe//cSzoHscOsNfHTsYJtoA357WIR9CV8VYx2Ajc65aP0y9D85W/OeOMGzpythl8wazmg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCg0Ty9ZjkDaSg6eSig3MRUTqvFj35Cx7QbLLOuXmNaridm0KT
 1dipfty+WTEqF6fK5XrNUa8QnpnTLdNpWDxpbSlpDZjPWaCYtYEjujStGQ/Ti03a7mw=
X-Gm-Gg: ATEYQzzPTPwp1k8as5ih6aMis4mE+R8qO6V/8STjOVhAmghnhxOC62fnly3h199VFzR
 BkHTaRCvoabwlklrK8/ttw0WeUZmGGlEWAFPTfCkLmrGbPwUBaDMmhyZJdjG4KdUzgSAJgDuyFg
 z+xS/cXlaKGG6B0nj5owdz61nuBni9X10Myx6eZDiUCskL4ZvEsJUWh0pzvfGc7+4mJPlGX5vD4
 IXIhVs0EzgEvQhg9cqSGeKGenf77IKJ6JmUx2dhLsZD1FQKv3nZxZUkQii5vQpPClKjezmQJie6
 MuFgGLF4FLeHaUQRvU+1zg3JACPqUZlhLM/naeSEmjxqqRMuya4y78bJIJZ5SnSUy687p64lMYa
 D/3nvUBMmTEifs0/6Xdih3Il4WczCyoIa6InZivTMNxE3vRtF+Vn8GHJLRui5vhMsvhTs+Nxi2m
 eCuRvoU9ydyJ7o/OFaxKYSkbKqobBc
X-Received: by 2002:a05:6000:438a:b0:43b:564d:c123 with SMTP id
 ffacd0b85a97d-43b8898d57amr9770384f8f.3.1774511918517; 
 Thu, 26 Mar 2026 00:58:38 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e7111sm5918551f8f.37.2026.03.26.00.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 00:58:37 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:58:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] clk: mediatek: Add mt8173-mfgtop driver
Message-ID: <202603261444.jANdMbNC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325071951.544031-3-wenst@chromium.org>
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

Hi Chen-Yu,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/dt-bindings-clock-mediatek-Add-mt8173-mfgtop/20260325-202618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20260325071951.544031-3-wenst%40chromium.org
patch subject: [PATCH v2 2/5] clk: mediatek: Add mt8173-mfgtop driver
config: csky-randconfig-r073-20260326 (https://download.01.org/0day-ci/archive/20260326/202603261444.jANdMbNC-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.5.0
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202603261444.jANdMbNC-lkp@intel.com/

smatch warnings:
drivers/clk/mediatek/clk-mt8173-mfgtop.c:163 clk_mt8173_mfgtop_probe() warn: missing error code 'ret'

vim +/ret +163 drivers/clk/mediatek/clk-mt8173-mfgtop.c

edc2074329e271 Chen-Yu Tsai 2026-03-25  153  	ret = mtk_clk_register_gates(dev, node, mfg_clks, ARRAY_SIZE(mfg_clks),
edc2074329e271 Chen-Yu Tsai 2026-03-25  154  				     data->clk_data);
edc2074329e271 Chen-Yu Tsai 2026-03-25  155  	if (ret) {
edc2074329e271 Chen-Yu Tsai 2026-03-25  156  		dev_err_probe(dev, ret, "Failed to register clock gates\n");
edc2074329e271 Chen-Yu Tsai 2026-03-25  157  		goto put_pm_runtime;
edc2074329e271 Chen-Yu Tsai 2026-03-25  158  	}
edc2074329e271 Chen-Yu Tsai 2026-03-25  159  
edc2074329e271 Chen-Yu Tsai 2026-03-25  160  	data->clk_26m = clk_hw_get_clk(data->clk_data->hws[CLK_MFG_26M], "26m");
edc2074329e271 Chen-Yu Tsai 2026-03-25  161  	if (IS_ERR(data->clk_26m)) {
edc2074329e271 Chen-Yu Tsai 2026-03-25  162  		dev_err_probe(dev, PTR_ERR(data->clk_26m), "Failed to get 26 MHz clock\n");
edc2074329e271 Chen-Yu Tsai 2026-03-25 @163  		goto unregister_clks;

ret = dev_err_probe() or ret = PTR_ERR(data->clk_26m)?

edc2074329e271 Chen-Yu Tsai 2026-03-25  164  	}
edc2074329e271 Chen-Yu Tsai 2026-03-25  165  
edc2074329e271 Chen-Yu Tsai 2026-03-25  166  	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data->clk_data);
edc2074329e271 Chen-Yu Tsai 2026-03-25  167  	if (ret) {
edc2074329e271 Chen-Yu Tsai 2026-03-25  168  		dev_err_probe(dev, ret, "Failed to add clk OF provider\n");
edc2074329e271 Chen-Yu Tsai 2026-03-25  169  		goto put_26m_clk;
edc2074329e271 Chen-Yu Tsai 2026-03-25  170  	}
edc2074329e271 Chen-Yu Tsai 2026-03-25  171  
edc2074329e271 Chen-Yu Tsai 2026-03-25  172  	data->genpd.name = "mfg-top";
edc2074329e271 Chen-Yu Tsai 2026-03-25  173  	data->genpd.power_on = clk_mt8173_mfgtop_power_on;
edc2074329e271 Chen-Yu Tsai 2026-03-25  174  	data->genpd.power_off = clk_mt8173_mfgtop_power_off;
edc2074329e271 Chen-Yu Tsai 2026-03-25  175  	ret = pm_genpd_init(&data->genpd, NULL, true);
edc2074329e271 Chen-Yu Tsai 2026-03-25  176  	if (ret) {
edc2074329e271 Chen-Yu Tsai 2026-03-25  177  		dev_err_probe(dev, ret, "Failed to add power domain\n");
edc2074329e271 Chen-Yu Tsai 2026-03-25  178  		goto del_clk_provider;
edc2074329e271 Chen-Yu Tsai 2026-03-25  179  	}
edc2074329e271 Chen-Yu Tsai 2026-03-25  180  
edc2074329e271 Chen-Yu Tsai 2026-03-25  181  	ret = of_genpd_add_provider_simple(node, &data->genpd);
edc2074329e271 Chen-Yu Tsai 2026-03-25  182  	if (ret) {
edc2074329e271 Chen-Yu Tsai 2026-03-25  183  		dev_err_probe(dev, ret, "Failed to add power domain OF provider\n");
edc2074329e271 Chen-Yu Tsai 2026-03-25  184  		goto remove_pd;
edc2074329e271 Chen-Yu Tsai 2026-03-25  185  	}
edc2074329e271 Chen-Yu Tsai 2026-03-25  186  
edc2074329e271 Chen-Yu Tsai 2026-03-25  187  	ret = of_genpd_add_subdomain(&data->parent_pd, &data->child_pd);
edc2074329e271 Chen-Yu Tsai 2026-03-25  188  	if (ret) {
edc2074329e271 Chen-Yu Tsai 2026-03-25  189  		dev_err_probe(dev, ret, "Failed to link PM domains\n");
edc2074329e271 Chen-Yu Tsai 2026-03-25  190  		goto del_pd_provider;
edc2074329e271 Chen-Yu Tsai 2026-03-25  191  	}
edc2074329e271 Chen-Yu Tsai 2026-03-25  192  
edc2074329e271 Chen-Yu Tsai 2026-03-25  193  	pm_runtime_put(dev);
edc2074329e271 Chen-Yu Tsai 2026-03-25  194  	return 0;
edc2074329e271 Chen-Yu Tsai 2026-03-25  195  
edc2074329e271 Chen-Yu Tsai 2026-03-25  196  del_pd_provider:
edc2074329e271 Chen-Yu Tsai 2026-03-25  197  	of_genpd_del_provider(node);
edc2074329e271 Chen-Yu Tsai 2026-03-25  198  remove_pd:
edc2074329e271 Chen-Yu Tsai 2026-03-25  199  	pm_genpd_remove(&data->genpd);
edc2074329e271 Chen-Yu Tsai 2026-03-25  200  del_clk_provider:
edc2074329e271 Chen-Yu Tsai 2026-03-25  201  	of_clk_del_provider(node);
edc2074329e271 Chen-Yu Tsai 2026-03-25  202  put_26m_clk:
edc2074329e271 Chen-Yu Tsai 2026-03-25  203  	clk_put(data->clk_26m);
edc2074329e271 Chen-Yu Tsai 2026-03-25  204  unregister_clks:
edc2074329e271 Chen-Yu Tsai 2026-03-25  205  	mtk_clk_unregister_gates(mfg_clks, ARRAY_SIZE(mfg_clks), data->clk_data);
edc2074329e271 Chen-Yu Tsai 2026-03-25  206  put_pm_runtime:
edc2074329e271 Chen-Yu Tsai 2026-03-25  207  	pm_runtime_put(dev);
edc2074329e271 Chen-Yu Tsai 2026-03-25  208  put_of_node:
edc2074329e271 Chen-Yu Tsai 2026-03-25  209  	of_node_put(data->parent_pd.np);
edc2074329e271 Chen-Yu Tsai 2026-03-25  210  	return ret;
edc2074329e271 Chen-Yu Tsai 2026-03-25  211  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

