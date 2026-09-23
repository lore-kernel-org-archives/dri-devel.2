Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6E3C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C140510F183;
	Wed, 23 Sep 2026 20:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ns8ydppm";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AA110F182
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:11:03 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so6611785e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194261; x=1790799061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tv2gyMGASSEUQ5phQtVihq/4jYMJzkV2HdzigXP4G4U=;
 b=ns8ydppmRQE3JBDzz0xEWGLtfOfEqu0ldY51/9vfinXT4QbSGrQ1nhV7txXYt59ddS
 18+mu7A9FBnjrSz5GO1UWXtCfM9/z3vMe+0QV8lyDSkakZe7fPFp0lVauDxRDjNB6SWU
 LVylxHka43qrKhZj3jaEGIoZfhXM/exgUoVGtbRXIjppkfIeudRzX7sy3pllyZSge9ka
 DkpSIqd1K+fQsknkQGpHfRIiH8uGtPG2583FAyRdBTqE7ZxAZssMOQJhqs9UZV6iGXqE
 vKNzBcLCCrlcZMg5Oyn+qH74Hgbjlf6X1ua9g2FcP+AlIN+tBBWWL+dE1YyJJp9V59X1
 LwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194261; x=1790799061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tv2gyMGASSEUQ5phQtVihq/4jYMJzkV2HdzigXP4G4U=;
 b=g3gxK1ZKE1jJJLJr8Fo0QkCIZ9tdarLKWf/VGM8IuEktIt3zSvMPw2E49RZt71HpUV
 xMBNfqXB1ZxxEW642tWVmO7vE/CE+usXTlzNFg25tUqyPNY6nczsp54789lCC4CJ21lI
 qmdcEUupCH3KbHDNvrbqW4L2AR1MWE9wHvqoJBQxxtIXDcepDZ0dpg2jmaeSYvVvcfc3
 sksHT+S9cmkpbcsO/4IvXkUVqFBXj9l2hE7Z6/Exj3CcKU7DxNWnDd4Q7UrbIpw0b0TD
 XQ0ubJuf25Y1Clc8Aq2k44P46IxRZcwuGjz7pu5wVvrpSxRoonu3GxYbfj9lO2oOV9Nv
 nEaw==
X-Forwarded-Encrypted: i=1;
 AKwUvByuS4pBFnsom1XJFOalEuACTf+pAve2WnrP4erU4qi2mNE73sreP1GIuAnulAXbCRAmve1+pvVKIlA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kVY6LcJRKc05Ris9tPKftH3jKWFPl0TN3FwOFyjM87DvgxFsqV
 /xOka5tSOVnaDq/q6p9BADTjeb29PbKDqbsW0GC9+v0936OtSdl9q+S/
X-Gm-Gg: AYBFou0kMQT2J2ZBbiZJZQEotaoKPfvBd1W0XvpBT0rH83UhKej81SkRqKCgjBR8sZV
 4vW37ltAUMrj4i+KEoG6YIKUB2I9bxE+G1eOuTAxDYQsEOrDC8SbvHCsdwMe6LAZv8lo0zooicw
 13Xfunltb7jKgq3ZrXfyzOQ9IEyH8i7/yoyeNKisyAITtruk2IxaAc2zURxDFkkEbcYF3YiUgo7
 26NZaQGxZCntw8QxvdqHM9IC3ngayqfkNFZZqjRmM4oZS56KJnRUgq9aVN5YFZiVoP9NLFgjlHG
 o8XGavcY5iiZbBYfzDy6pXDstTjd9NbzpHIlefP//6GBvjmtlVpWvv6EBe3tUEvadza72KVcRGA
 lyx7VX1SapGVc0yQsGEq+kztibLG36FJzJhFUsDQdjoETJBDG5nrQaX46pheFgkvhW3iZ6o7Jwg
 RCYr+Uj52d1ClpKJUJwI1I74QE2t3DwFomccqko6jGl1dPd7WycEV8mhp8j47PF4u+NeesUOwuR
 HO75cPesMt5rE+LZkuhc0Owq6MW0yXezFQ=
X-Received: by 2002:a05:600c:4e53:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49fe66c8288mr4894915e9.4.1790194261482; 
 Wed, 23 Sep 2026 13:11:01 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:11:01 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v3 7/7] video: logo: add ppmtodtlogo host tool
Date: Wed, 23 Sep 2026 22:10:35 +0200
Message-Id: <20260923201035.51007-8-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260923201035.51007-1-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The byte arrays a "boot-logo-clut224" node carries are not meant to
be written by hand. Add a host tool that converts a PPM image into the
node, along the lines of the existing pnmtologo: plain C, no dependencies,
and no quantization of its own -- the image must already use at most 224
distinct colours, and the tool points at ImageMagick when it does not.

Three output flavours:

  ppmtodtlogo logo.ppm                  a complete overlay
  ppmtodtlogo -t dtsi logo.ppm          a bare node, for inclusion
  ppmtodtlogo -t bin -o logo.bin ...    the blob for a reserved memory
                                        region, header included

The devicetree outputs also carry the optional placement properties,
commented out unless requested on the command line, so the generated file
documents what can be tuned without regenerating the image.

The tool is built when CONFIG_LOGO_DT_CLUT224 is enabled but is not used
by the kernel build itself.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 drivers/video/logo/Makefile      |   6 +-
 drivers/video/logo/ppmtodtlogo.c | 416 +++++++++++++++++++++++++++++++
 2 files changed, 421 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/logo/ppmtodtlogo.c

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 937b37d3b6..6dc205d24e 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -10,7 +10,11 @@ obj-$(CONFIG_SPU_BASE)			+= logo_spe_clut224.o
 
 # How to generate logo's
 
-hostprogs := pnmtologo
+hostprogs := pnmtologo ppmtodtlogo
+
+# Not used by the build itself: converts a user's image into the devicetree
+# node or memory blob the "boot-logo-clut224" binding consumes.
+always-$(CONFIG_LOGO_DT_CLUT224) += ppmtodtlogo
 
 # Create commands like "pnmtologo -t mono -n logo_linux_mono -o ..."
 quiet_cmd_logo = LOGO    $@
diff --git a/drivers/video/logo/ppmtodtlogo.c b/drivers/video/logo/ppmtodtlogo.c
new file mode 100644
index 0000000000..7fded9ce9b
--- /dev/null
+++ b/drivers/video/logo/ppmtodtlogo.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Convert a PPM image into a devicetree boot logo node, or into the binary
+ * blob the "boot-logo-clut224" binding reads from a reserved memory
+ * region.
+ *
+ * Like pnmtologo, this tool does not quantize: the image must already use
+ * at most 224 distinct colours. Reduce it first if needed, for instance:
+ *
+ *	magick logo.png -colors 224 logo.ppm
+ *
+ * The node is emitted under /chosen, where the binding expects it: a logo is
+ * configuration handed over by firmware rather than a description of the
+ * hardware.
+ *
+ * The devicetree output stores plain palette indices; the 32 entry offset
+ * the frame buffer layer reserves for the console is applied by the kernel.
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#define MAX_CLUT_COLORS	224
+/* Keep in step with LOGO_DT_MAX_PIXELS in drivers/video/logo/logo.c */
+#define MAX_PIXELS	(16U * 1024 * 1024)
+#define BLOB_MAGIC	0x4f474f4cU	/* "LOGO", little endian */
+#define BYTES_PER_LINE	12
+
+static const char *programname;
+static const char *filename;
+static const char *outputname;
+static FILE *out;
+
+enum output_type {
+	OUTPUT_DTS,	/* complete overlay */
+	OUTPUT_DTSI,	/* bare node, for inclusion */
+	OUTPUT_BIN,	/* blob for a reserved memory region */
+};
+
+static enum output_type output_type = OUTPUT_DTS;
+
+/* Placement options, emitted into the node */
+static int opt_centered;
+static char *opt_position;
+static char *opt_offset;
+static const char *opt_rotation;
+
+struct color {
+	unsigned char red;
+	unsigned char green;
+	unsigned char blue;
+};
+
+static unsigned int logo_width;
+static unsigned int logo_height;
+static unsigned char *logo_data;
+static struct color logo_clut[MAX_CLUT_COLORS];
+static unsigned int logo_clutsize;
+
+static void die(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	exit(1);
+}
+
+static void usage(void)
+{
+	die("Usage: %s [options] <filename>\n"
+	    "\n"
+	    "Convert a PPM image into a \"boot-logo-clut224\" node.\n"
+	    "The image must use at most %d distinct colours.\n"
+	    "\n"
+	    "    -o <output>     write to file instead of stdout\n"
+	    "    -t <type>       dts (default), dtsi or bin\n"
+	    "    -c              centre the logo (logo-position = <(-1) (-1)>)\n"
+	    "    -p <x>,<y>      logo-position, -1 on an axis centres it\n"
+	    "    -f <dx>,<dy>    logo-offset\n"
+	    "    -r <rotation>   logo-rotation: cw, ccw, ud or none\n"
+	    "    -h              this help\n",
+	    programname, MAX_CLUT_COLORS);
+}
+
+static unsigned int get_number(FILE *fp)
+{
+	int c;
+	unsigned int val;
+
+	/* Skip leading whitespace */
+	do {
+		c = fgetc(fp);
+		if (c == EOF)
+			die("%s: end of file\n", filename);
+		if (c == '#') {
+			/* Ignore comments 'till end of line */
+			do {
+				c = fgetc(fp);
+				if (c == EOF)
+					die("%s: end of file\n", filename);
+			} while (c != '\n');
+		}
+	} while (isspace(c));
+
+	if (!isdigit(c))
+		die("%s: expected a number\n", filename);
+
+	/* Parse decimal number */
+	val = 0;
+	while (isdigit(c)) {
+		val = 10 * val + c - '0';
+		c = fgetc(fp);
+		if (c == EOF)
+			break;
+	}
+	return val;
+}
+
+static unsigned char get_byte(FILE *fp)
+{
+	int c = fgetc(fp);
+
+	if (c == EOF)
+		die("%s: end of file\n", filename);
+	return c;
+}
+
+static unsigned int find_clut_entry(struct color color)
+{
+	unsigned int i;
+
+	for (i = 0; i < logo_clutsize; i++)
+		if (logo_clut[i].red == color.red &&
+		    logo_clut[i].green == color.green &&
+		    logo_clut[i].blue == color.blue)
+			return i;
+
+	if (logo_clutsize == MAX_CLUT_COLORS)
+		die("%s: more than %d colors, reduce the image first, e.g.\n"
+		    "    magick %s -colors %d out.ppm\n",
+		    filename, MAX_CLUT_COLORS, filename, MAX_CLUT_COLORS);
+
+	logo_clut[logo_clutsize] = color;
+	return logo_clutsize++;
+}
+
+static void read_image(void)
+{
+	unsigned int i, npixels, maxval;
+	int magic, raw;
+	FILE *fp;
+
+	fp = fopen(filename, "rb");
+	if (!fp)
+		die("Cannot open file %s: %s\n", filename, strerror(errno));
+
+	if (fgetc(fp) != 'P')
+		die("%s is not a PPM file\n", filename);
+
+	magic = fgetc(fp);
+	switch (magic) {
+	case '3':
+		raw = 0;
+		break;
+	case '6':
+		raw = 1;
+		break;
+	default:
+		die("%s is not a PPM file (only P3 and P6 are supported)\n",
+		    filename);
+	}
+
+	logo_width = get_number(fp);
+	logo_height = get_number(fp);
+	maxval = get_number(fp);
+	if (maxval != 255)
+		die("%s: maximum color value must be 255\n", filename);
+
+	if (!logo_width || !logo_height)
+		die("%s: zero sized image\n", filename);
+	if ((unsigned long long)logo_width * logo_height > MAX_PIXELS)
+		die("%s: image too large\n", filename);
+
+	npixels = logo_width * logo_height;
+	logo_data = malloc(npixels);
+	if (!logo_data)
+		die("%s\n", strerror(errno));
+
+	for (i = 0; i < npixels; i++) {
+		struct color color;
+
+		if (raw) {
+			color.red = get_byte(fp);
+			color.green = get_byte(fp);
+			color.blue = get_byte(fp);
+		} else {
+			color.red = get_number(fp);
+			color.green = get_number(fp);
+			color.blue = get_number(fp);
+		}
+		logo_data[i] = find_clut_entry(color);
+	}
+
+	fclose(fp);
+}
+
+static void write_bytes(const unsigned char *data, unsigned int len,
+			const char *indent)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; i++) {
+		if (i % BYTES_PER_LINE == 0)
+			fprintf(out, "%s%s", i ? "\n" : "", indent);
+		else
+			fputc(' ', out);
+		fprintf(out, "0x%02x", data[i]);
+	}
+}
+
+static void write_placement(const char *indent)
+{
+	const char *pos = "0 0";
+
+	fprintf(out, "%s/* logo-position gives the top left corner; -1 on an axis\n",
+		indent);
+	fprintf(out, "%s * centres it there. logo-offset is added afterwards. */\n",
+		indent);
+
+	/* -c is a shorthand for centring on both axes; -p wins over it */
+	if (opt_position)
+		pos = opt_position;
+	else if (opt_centered)
+		pos = "(-1) (-1)";
+
+	fprintf(out, "%s%slogo-position = <%s>;\n", indent,
+		opt_position || opt_centered ? "" : "// ", pos);
+	fprintf(out, "%s%slogo-offset = <%s>;\n", indent,
+		opt_offset ? "" : "// ", opt_offset ? opt_offset : "0 0");
+	fprintf(out, "%s%slogo-rotation = \"%s\";\t/* cw, ccw, ud, none */\n",
+		indent, opt_rotation ? "" : "// ",
+		opt_rotation ? opt_rotation : "ccw");
+}
+
+static void write_node(const char *indent)
+{
+	char subindent[16];
+
+	snprintf(subindent, sizeof(subindent), "%s\t\t", indent);
+
+	fprintf(out, "%scompatible = \"boot-logo-clut224\";\n", indent);
+	fprintf(out, "\n");
+	write_placement(indent);
+	fprintf(out, "\n");
+	fprintf(out, "%swidth = <%u>;\n", indent, logo_width);
+	fprintf(out, "%sheight = <%u>;\n", indent, logo_height);
+	fprintf(out, "\n");
+	fprintf(out, "%sclut = /bits/ 8 <", indent);
+	write_bytes((const unsigned char *)logo_clut, logo_clutsize * 3,
+		    subindent);
+	fprintf(out, ">;\n");
+	fprintf(out, "\n");
+	fprintf(out, "%sdata = /bits/ 8 <", indent);
+	write_bytes(logo_data, logo_width * logo_height, subindent);
+	fprintf(out, ">;\n");
+}
+
+static void write_header_comment(void)
+{
+	fprintf(out, "/*\n");
+	fprintf(out, " * Boot logo generated by ppmtodtlogo from %s\n",
+		filename);
+	fprintf(out, " * %ux%u pixels, %u colours.\n", logo_width, logo_height,
+		logo_clutsize);
+	fprintf(out, " */\n");
+}
+
+static void write_dts(void)
+{
+	fprintf(out, "/dts-v1/;\n/plugin/;\n\n");
+	write_header_comment();
+	fprintf(out, "\n");
+	fprintf(out, "/ {\n");
+	fprintf(out, "\tfragment@101 {\n");
+	fprintf(out, "\t\ttarget-path = \"/chosen\";\n");
+	fprintf(out, "\n");
+	fprintf(out, "\t\t__overlay__ {\n");
+	fprintf(out, "\t\t\tlogo {\n");
+	write_node("\t\t\t\t");
+	fprintf(out, "\t\t\t};\n");
+	fprintf(out, "\t\t};\n");
+	fprintf(out, "\t};\n");
+	fprintf(out, "};\n");
+}
+
+static void write_dtsi(void)
+{
+	write_header_comment();
+	fprintf(out, "\n");
+	fprintf(out, "chosen {\n");
+	fprintf(out, "\tlogo {\n");
+	write_node("\t\t");
+	fprintf(out, "\t};\n");
+	fprintf(out, "};\n");
+}
+
+static void put_le32(unsigned int val)
+{
+	fputc(val & 0xff, out);
+	fputc((val >> 8) & 0xff, out);
+	fputc((val >> 16) & 0xff, out);
+	fputc((val >> 24) & 0xff, out);
+}
+
+static void write_bin(void)
+{
+	put_le32(BLOB_MAGIC);
+	put_le32(logo_width);
+	put_le32(logo_height);
+	put_le32(logo_clutsize);
+	fwrite(logo_clut, 3, logo_clutsize, out);
+	fwrite(logo_data, 1, logo_width * logo_height, out);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt;
+	char *p;
+
+	programname = argv[0];
+
+	while ((opt = getopt(argc, argv, "o:t:cp:f:r:h")) != -1) {
+		switch (opt) {
+		case 'o':
+			outputname = optarg;
+			break;
+		case 't':
+			if (!strcmp(optarg, "dts"))
+				output_type = OUTPUT_DTS;
+			else if (!strcmp(optarg, "dtsi"))
+				output_type = OUTPUT_DTSI;
+			else if (!strcmp(optarg, "bin"))
+				output_type = OUTPUT_BIN;
+			else
+				usage();
+			break;
+		case 'c':
+			opt_centered = 1;
+			break;
+		case 'p':
+			opt_position = optarg;
+			break;
+		case 'f':
+			opt_offset = optarg;
+			break;
+		case 'r':
+			if (strcmp(optarg, "cw") && strcmp(optarg, "ccw") &&
+			    strcmp(optarg, "ud") && strcmp(optarg, "none"))
+				usage();
+			opt_rotation = optarg;
+			break;
+		default:
+			usage();
+		}
+	}
+	if (optind != argc - 1)
+		usage();
+	filename = argv[optind];
+
+	/* "10,20" and "10 20" are both accepted for -p and -f */
+	for (p = opt_position; p && *p; p++)
+		if (*p == ',')
+			*p = ' ';
+	for (p = opt_offset; p && *p; p++)
+		if (*p == ',')
+			*p = ' ';
+
+	read_image();
+
+	if (outputname) {
+		out = fopen(outputname,
+			    output_type == OUTPUT_BIN ? "wb" : "w");
+		if (!out)
+			die("Cannot create file %s: %s\n", outputname,
+			    strerror(errno));
+	} else {
+		out = stdout;
+	}
+
+	switch (output_type) {
+	case OUTPUT_DTS:
+		write_dts();
+		break;
+	case OUTPUT_DTSI:
+		write_dtsi();
+		break;
+	case OUTPUT_BIN:
+		write_bin();
+		break;
+	}
+
+	if (outputname)
+		fclose(out);
+
+	fprintf(stderr, "%s: %ux%u pixels, %u colours\n", filename, logo_width,
+		logo_height, logo_clutsize);
+
+	return 0;
+}
-- 
2.39.5

